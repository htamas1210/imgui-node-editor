project "ImGuiNodeEditor"
    kind "StaticLib"
    language "C++"
    staticruntime "off"
    cppdialect "C++20"

    -- Escape libs/imgui-node-editor/ and output to the root build folder
    targetdir ("../../build/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("../../build/bin-int/" .. outputdir .. "/%{prj.name}")

    -- Globbing is perfect here, it grabs all the root source files
    -- while ignoring the docs/ examples/ and external/ folders automatically
    files {
        "*.cpp",
        "*.h",
        "*.inl"
    }

    includedirs {
        "./",
        "../imgui" -- Tells the node editor where to find imgui.h
    }

    filter "system:windows"
        systemversion "latest"

    filter "system:linux"
        pic "On"
        systemversion "latest"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        symbols "off"
