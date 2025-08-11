/// 객체 널 체크 익스텐션
extension NotNull<T extends Object> on T {
  void ifNotNull(Function(T) action) {
    action(this);
  }

  Object? ifNotNullValue() {
    switch (this) {
      case var s:
        return s;
    }
  }
}
