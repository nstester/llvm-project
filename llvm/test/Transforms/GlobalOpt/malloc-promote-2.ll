; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; RUN: opt < %s -passes=globalopt -S | FileCheck %s
target datalayout = "E-p:64:64:64-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

@G = internal global ptr null

define void @t() {
; CHECK-LABEL: @t(
; CHECK-NEXT:    ret void
;
  %malloccall = tail call ptr @malloc(i64 400)
  store ptr %malloccall, ptr @G
  %GV = load ptr, ptr @G
  %GVe = getelementptr i32, ptr %GV, i32 40
  store i32 20, ptr %GVe
  ret void
}

declare noalias ptr @malloc(i64) allockind("alloc,uninitialized") allocsize(0)

define void @foo(i64 %Size) nounwind noinline #0 {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load ptr, ptr @G, align 4
  ret void
}

attributes #0 = { null_pointer_is_valid }
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { noinline nounwind null_pointer_is_valid }
;.
