set guards

update:
  rosdep update
  uv self update
  uv sync

full-fix: lint-fix && format

format:
  uv run ruff format

format-check:
  uv run ruff format --check

lint:
  uv run ruff check
  yamllint .
  clang-tidy

lint-fix:
  uv run ruff check --fix
  clang-tidy --fix

mod install
mod? embedded 'src/embedded'
