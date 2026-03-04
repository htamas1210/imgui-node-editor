cmake_minimum_required(VERSION 3.15)
project(ImGuiNodeEditor LANGUAGES CXX)

# 1. Grab all the root source files
# We use standard GLOB here (not GLOB_RECURSE) to perfectly match your Premake setup,
# ensuring it ignores nested folders like docs/ or examples/.
file(GLOB NODE_EDITOR_SOURCES
    "*.cpp"
    "*.h"
    "*.inl"
)

# 2. Create the Static Library 
add_library(ImGuiNodeEditor STATIC ${NODE_EDITOR_SOURCES})

# 3. Enforce C++20 (from your cppdialect "C++20" filter) 
target_compile_features(ImGuiNodeEditor PUBLIC cxx_std_20)

# Disable static runtime (Equivalent to staticruntime "off") 
set_property(TARGET ImGuiNodeEditor PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>DLL")

# 4. Include directories & Linking
# PUBLIC means anything linking to ImGuiNodeEditor will automatically know where its headers are.
target_include_directories(ImGuiNodeEditor PUBLIC 
    "${CMAKE_CURRENT_SOURCE_DIR}"
)

# Here is the CMake magic: Instead of hardcoding "../imgui" like in Premake,
# we simply tell it to link to your ImGui target. It will automatically inherit
# ImGui's include directories!
target_link_libraries(ImGuiNodeEditor PRIVATE ImGui)

# 5. OS Specific Filters
if(UNIX AND NOT APPLE)
    # Equivalent to pic "On" in Linux 
    set_property(TARGET ImGuiNodeEditor PROPERTY POSITION_INDEPENDENT_CODE ON)
endif()
