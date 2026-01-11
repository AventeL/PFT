# Testing Guide - PFT Project

## Quick Start

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Specific Test File

```bash
flutter test test/domain/usecases/search_exercises_test.dart
```

### Use Test Script

```bash
chmod +x run_tests.sh
./run_tests.sh
```

## Test Structure

```
test/
├── helpers/
│   ├── test_helpers.dart           # Mock generation config
│   └── test_helpers.mocks.dart     # Generated mocks (auto-generated)
├── domain/
│   ├── entities/
│   │   └── exercise_test.dart
│   └── usecases/
│       └── search_exercises_test.dart
├── data/
│   └── models/
│       └── exercise_model_test.dart
├── presentation/
│   ├── blocs/
│   │   ├── exercise_bloc_test.dart
│   │   └── exercise_bloc_search_filter_test.dart
│   ├── screens/
│   │   └── exercise_list_screen_test.dart
│   └── widgets/
│       └── exercise_list_item_test.dart
└── widget_test.dart
```

## Test Categories

### Unit Tests (Domain Layer)

Tests for business logic and use cases:

- `search_exercises_test.dart` - 14 tests covering all search and filter scenarios

### BLoC Tests (Presentation Layer)

Tests for state management:

- `exercise_bloc_test.dart` - Core exercise BLoC functionality
- `exercise_bloc_search_filter_test.dart` - Search and filter feature tests

### Widget Tests

Tests for UI components:

- `exercise_list_screen_test.dart` - Exercise list screen tests
- `exercise_list_item_test.dart` - List item widget tests

### Integration Tests

- `widget_test.dart` - App smoke tests

## Mocking Strategy

This project uses a hybrid mocking approach:

### Mocktail (for use cases with `call()` method)

Used for: `GetExercises`, `SearchExercises`, `CreateCustomExercise`, `SeedExercises`

```dart
import 'package:mocktail/mocktail.dart';

class MockSearchExercises extends Mock implements SearchExercises {}

// In tests:
when
(
() => mockSearchExercises(...)).thenAnswer((
_
)
async
=>
result
);
```

### Mockito with Generated Mocks (for repositories)

Used for: `ExerciseRepository` and other non-callable classes

```dart
import 'package:mockito/mockito.dart';
import '../../helpers/test_helpers.mocks.dart';

// Mocks are already generated
final mockRepository = MockExerciseRepository();

// In tests:
when
(
mockRepository.method()).thenAnswer((_)
async
=>
result
);
```

## Regenerating Mocks

If you add new classes that need mocking:

1. Add the class to `test/helpers/test_helpers.dart`:

```dart
@GenerateMocks([
  ExerciseRepository,
  YourNewClass, // Add here
])
```

2. Run the build_runner:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. The generated mocks will be in `test/helpers/test_helpers.mocks.dart`

## Test Coverage

### Current Coverage by Story

**Story 2.1 - Exercise Database** ✅

- Domain entities: ✅ Covered
- Data models: ✅ Covered
- Use cases: ✅ Covered
- BLoC: ✅ Covered
- Widgets: ✅ Covered

**Story 2.2 - Search & Filter** ✅ (Unit tests only)

- Domain layer (SearchExercises): ✅ 14 tests
- BLoC layer (filter events): ✅ 10 tests
- Widget tests: ⏳ TODO (Task 7)
- Performance tests: ⏳ TODO (Task 8)

### Coverage Goals

- Unit Tests: >80% coverage
- Widget Tests: All user-facing widgets
- Integration Tests: Critical user flows

## Running Specific Test Suites

### Story 2.2 Tests Only

```bash
flutter test test/domain/usecases/search_exercises_test.dart test/presentation/blocs/exercise_bloc_search_filter_test.dart
```

### All BLoC Tests

```bash
flutter test test/presentation/blocs/
```

### All Domain Tests

```bash
flutter test test/domain/
```

### All Widget Tests

```bash
flutter test test/presentation/widgets/ test/presentation/screens/
```

## Debugging Tests

### Run Tests in Debug Mode

```bash
flutter test --debug test/path/to/test_file.dart
```

### Run Single Test

```bash
flutter test test/path/to/test_file.dart --name "test name"
```

### Verbose Output

```bash
flutter test --reporter expanded
```

## Common Issues

### Issue: Mock not found

**Solution**: Regenerate mocks with
`flutter pub run build_runner build --delete-conflicting-outputs`

### Issue: Type mismatch with `any()`

**Solution**:

- With mockito: Use `any` without parentheses
- With mocktail: Use `any()` or `any(named: 'paramName')`

### Issue: `call()` method not mocked properly

**Solution**: Use mocktail for classes with `call()` method, use syntax `when(() => mock(...))`

### Issue: Tests hanging

**Solution**:

1. Check for missing `await` in async tests
2. Ensure all futures are properly mocked
3. Use `tester.pumpAndSettle()` in widget tests

## Best Practices

1. **Arrange-Act-Assert**: Structure tests clearly
2. **One Assertion per Test**: Keep tests focused
3. **Descriptive Names**: Test names should describe the scenario
4. **Mock Only What You Need**: Don't over-mock
5. **Clean Up**: Use `tearDown()` to close resources
6. **Use `const` When Possible**: For better performance
7. **Test Edge Cases**: Empty lists, null values, errors

## CI/CD Integration

For continuous integration, add to your pipeline:

```yaml
# Example for GitHub Actions
- name: Run Tests
  run: flutter test --coverage

- name: Upload Coverage
  uses: codecov/codecov-action@v3
  with:
    file: coverage/lcov.info
```

## Additional Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [BLoC Test Documentation](https://pub.dev/packages/bloc_test)

---

**Last Updated**: 2026-01-11
**Project**: PFT (Performance Fitness Tracker)

