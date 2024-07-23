echo "$TARGET"

# if target equals "all" then run all tests

if [ "$TARGET" = "all" ]; then
    echo "Running all tests"
    pytest --log-cli-level=INFO -x -s -vvv --durations=5 --color=yes tests/ -W ignore::DeprecationWarning -W ignore::DeprecationWarning
else
    echo "Running tests for $TARGET"
    pytest --log-cli-level=INFO -x -s -vvv --durations=5 --color=yes "tests/test_$TARGET.py" -W ignore::DeprecationWarning -W ignore::DeprecationWarning
fi
cov_exit_code=$?

test_exit_code=$?
exit_code=$((cov_exit_code + test_exit_code))

echo "Test exit code: $test_exit_code"
echo "Exit code: $exit_code"

exit "$exit_code"
