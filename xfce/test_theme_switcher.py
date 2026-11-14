"""Run with: python3 -B -m unittest -v"""

import contextlib
import importlib.machinery
import importlib.util
import io
import pathlib
import subprocess
import tempfile
import unittest
from unittest import mock


SCRIPT = pathlib.Path(__file__).resolve().parent / "theme-switcher"
loader = importlib.machinery.SourceFileLoader("theme_switcher", str(SCRIPT))
spec = importlib.util.spec_from_loader(loader.name, loader)
switcher = importlib.util.module_from_spec(spec)
loader.exec_module(switcher)


class ThemeSwitcherTests(unittest.TestCase):
    def load(self, content):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / "test.conf"
            path.write_text(content, encoding="utf-8")
            return switcher.load_preset(path)[0]

    def run_cli(self, *args):
        output = io.StringIO()
        with mock.patch("sys.argv", [str(SCRIPT), *args]):
            with contextlib.redirect_stdout(output), contextlib.redirect_stderr(output):
                code = switcher.main()
        return code, output.getvalue()

    def test_bundled_presets(self):
        for path in switcher.PRESET_DIR.glob("*.conf"):
            changes, _ = switcher.load_preset(path)
            self.assertTrue(changes, path.name)

    def test_default_cursor_settings(self):
        self.assertEqual(
            self.load("[appearance]\ncursor_theme =\ncursor_size = 0\n"),
            [("xsettings", "/Gtk/CursorThemeName", "string", ""),
             ("xsettings", "/Gtk/CursorThemeSize", "int", "0")],
        )

    def test_types_and_spaces(self):
        self.assertEqual(
            self.load("[appearance]\ngtk_theme = My Theme\nprefer_dark = yes\ncursor_size = 32\n"),
            [("xsettings", "/Net/ThemeName", "string", "My Theme"),
             ("xsettings", "/Gtk/ApplicationPreferDarkTheme", "bool", "true"),
             ("xsettings", "/Gtk/CursorThemeSize", "int", "32")],
        )

    def test_invalid_presets(self):
        for content in ("", "[wrong]\na = b", "[appearance]\ntypo = x",
                        "[appearance]\ncursor_size = -1", "[appearance]\nprefer_dark = maybe",
                        "[appearance]\nfont =", "[DEFAULT]\nfont = Sans"):
            with self.subTest(content=content), self.assertRaises(ValueError):
                self.load(content)

    def test_dry_run_does_not_call_xfconf(self):
        with mock.patch.object(switcher.subprocess, "run") as run:
            code, output = self.run_cli("apply", "dark", "--dry-run")
        self.assertEqual(code, 0)
        self.assertIn("--type bool --set true", output)
        run.assert_not_called()

    def test_apply_existing_and_missing_properties(self):
        for exists in (True, False):
            def result(command, **kwargs):
                return subprocess.CompletedProcess(command, 0 if "--set" in command or exists else 1, "", "")

            with self.subTest(exists=exists), mock.patch.object(switcher.shutil, "which", return_value="xfconf-query"):
                with mock.patch.object(switcher.subprocess, "run", side_effect=result) as run:
                    code, _ = self.run_cli("apply", "dark")
                self.assertEqual(code, 0)
                setters = [call.args[0] for call in run.call_args_list if "--set" in call.args[0]]
                self.assertEqual(len(setters), 10)
                self.assertTrue(all(("--create" in command) == (not exists) for command in setters))

    def test_reject_path(self):
        code, output = self.run_cli("apply", "../dark")
        self.assertEqual(code, 1)
        self.assertIn("not a path", output)

    def test_panel_profile_lookup(self):
        with tempfile.TemporaryDirectory() as directory:
            archive = pathlib.Path(directory) / "xfce4-panel-profiles" / "My Panel.tar.bz2"
            archive.parent.mkdir()
            archive.touch()
            with mock.patch.dict(switcher.os.environ, {"XDG_DATA_HOME": directory}):
                self.assertEqual(switcher.panel_command("My Panel"),
                                 ["xfce4-panel-profiles", "load", str(archive)])

    def test_panel_dry_run(self):
        command = ["xfce4-panel-profiles", "load", "/profiles/Windows95.tar.bz2"]
        with mock.patch.object(switcher, "panel_command", return_value=command):
            with mock.patch.object(switcher.subprocess, "run") as run:
                code, output = self.run_cli("apply", "windows95", "--dry-run")
        self.assertEqual(code, 0)
        self.assertIn("xfce4-panel-profiles load /profiles/Windows95.tar.bz2", output)
        run.assert_not_called()

    def test_panel_applied_after_appearance(self):
        command = ["xfce4-panel-profiles", "load", "/profiles/Windows95.tar.bz2"]
        with mock.patch.object(switcher, "panel_command", return_value=command):
            with mock.patch.object(switcher.shutil, "which", return_value="installed"):
                with mock.patch.object(switcher.subprocess, "run", return_value=subprocess.CompletedProcess([], 0)) as run:
                    code, _ = self.run_cli("apply", "windows95")
        self.assertEqual(code, 0)
        self.assertEqual(run.call_args_list[-1].args[0], command)

    def test_missing_panel_tool_does_not_change_settings(self):
        with mock.patch.object(switcher, "panel_command", return_value=["xfce4-panel-profiles", "load", "profile"]):
            with mock.patch.object(switcher.shutil, "which", return_value=None):
                with mock.patch.object(switcher.subprocess, "run") as run:
                    code, output = self.run_cli("apply", "windows95")
        self.assertEqual(code, 1)
        self.assertIn("xfce4-panel-profiles is missing", output)
        run.assert_not_called()


if __name__ == "__main__":
    unittest.main()
