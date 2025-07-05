cmake_minimum_required(VERSION 3.10)
project(OrderTest)

# 测试1：正确的顺序
message("=== 测试1：正确的顺序 ===")
add_executable(TestTarget test.cxx)
target_link_libraries(TestTarget INTERFACE)

# 测试2：错误的顺序（注释掉，避免报错）
message("=== 测试2：错误的顺序（被注释） ===")
# target_link_libraries(NonExistentTarget INTERFACE)  # 这会报错
# add_executable(NonExistentTarget test.cxx)

# 测试3：依赖目标必须存在
message("=== 测试3：依赖目标必须存在 ===")
add_library(MyLib lib.cxx)
add_executable(MyApp app.cxx)
target_link_libraries(MyApp PUBLIC MyLib)  # ✅ 正确：MyLib已存在

# 测试4：错误的依赖（注释掉）
# target_link_libraries(MyApp PUBLIC NonExistentLib)  # ❌ 错误：NonExistentLib不存在 