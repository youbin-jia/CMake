cmake_minimum_required(VERSION 3.10)
project(GeneratorExpressionsDemo)

# 1. 创建接口库
add_library(compiler_flags INTERFACE)

# 2. 设置C++标准
target_compile_features(compiler_flags INTERFACE cxx_std_11)

# 3. 检测编译器类型
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

# 4. 设置条件编译选项（不使用BUILD_INTERFACE）
target_compile_options(compiler_flags INTERFACE
                       "$<${gcc_like_cxx}:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>"
                       "$<${msvc_cxx}:-W3>"
                       )

# 5. 创建可执行文件
add_executable(demo demo.cxx)

# 6. 链接编译器标志
target_link_libraries(demo PUBLIC compiler_flags)

# 7. 演示不同的生成器表达式
message(STATUS "编译器检测:")
message(STATUS "  GCC类编译器: $<${gcc_like_cxx}>")
message(STATUS "  MSVC编译器: $<${msvc_cxx}>")

# 8. 演示条件编译
target_compile_definitions(demo PRIVATE
                          "$<${gcc_like_cxx}:GCC_LIKE_COMPILER>"
                          "$<${msvc_cxx}:MSVC_COMPILER>"
                          ) 