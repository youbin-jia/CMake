cmake_minimum_required(VERSION 3.10)
project(BuildInterfaceDemo)

# 演示1：不使用BUILD_INTERFACE的库
add_library(flags_without_build_interface INTERFACE)
target_compile_options(flags_without_build_interface INTERFACE
                       "$<COMPILE_LANG_AND_ID:CXX,GNU>:-Wall;-Wextra>"
                       )

# 演示2：使用BUILD_INTERFACE的库
add_library(flags_with_build_interface INTERFACE)
target_compile_options(flags_with_build_interface INTERFACE
                       "$<COMPILE_LANG_AND_ID:CXX,GNU>:$<BUILD_INTERFACE:-Wall;-Wextra>>"
                       )

# 演示3：使用这些库的目标
add_executable(app1 app1.cxx)
target_link_libraries(app1 PUBLIC flags_without_build_interface)

add_executable(app2 app2.cxx)
target_link_libraries(app2 PUBLIC flags_with_build_interface)

# 演示4：外部项目使用这些库
add_executable(external_app external.cxx)
# 如果这个外部项目链接flags_without_build_interface，会继承警告选项
# 如果这个外部项目链接flags_with_build_interface，不会继承警告选项 