"""Test code compliance."""

from re import match

from arch_mirror.sync import run_command


def test_ruff_check() -> None:
    """Test ruff check."""
    stdout, returncode = run_command("poetry run ruff check .")
    assert stdout.decode() == "All checks passed!\n"
    assert returncode == 0


def test_ruff_format() -> None:
    """Test ruff format."""
    stdout, returncode = run_command("poetry run ruff format --check .")
    assert match(r"\d files already formatted", stdout.decode())
    assert returncode == 0


def test_mypy_check() -> None:
    """Test mypy check."""
    stdout, returncode = run_command("poetry run mypy .")
    assert match(r"Success: no issues found in \d source files", stdout.decode())
    assert returncode == 0
