SDL2_DIR     = "sdl2"
SDL2_INCLUDE = SDL2_DIR.."/include"

local solution_name = _ACTION

if _ACTION == "ios" then
    solution_name = _ACTION
    _ACTION = "xcode4"
    system "ios"
end

workspace "sdl2"
    targetdir "bin/%{_ACTION}-%{cfg.platform}-%{cfg.buildcfg}/%{prj.name}"
    objdir "temp/%{_ACTION}-%{cfg.platform}-%{cfg.buildcfg}/%{prj.name}"
    location (path.join("project", solution_name))
    configurations { "Release", "Debug" }

project "sdl2"
    kind "StaticLib"
    language "C"
    defines "HAVE_LIBC" -- StaticLib
    --defines "SDL_SHARED" -- SharedLib
    includedirs { 
        path.join(SDL2_DIR, "include"),
    }
    files {
        path.join(SDL2_DIR, "include/**"),
        path.join(SDL2_DIR, "src/*.c"),
        path.join(SDL2_DIR, "src/*.h"),
        path.join(SDL2_DIR, "src/cpuinfo/**"),
        path.join(SDL2_DIR, "src/dynapi/**"),
        path.join(SDL2_DIR, "src/atomic/**"),
        path.join(SDL2_DIR, "src/libm/**"),
        path.join(SDL2_DIR, "src/stdlib/**"),
        path.join(SDL2_DIR, "src/filesystem/dummy/**"),
        path.join(SDL2_DIR, "src/loadso/dummy/**"),
        -- AUDIO --
        path.join(SDL2_DIR, "src/audio/*.c"),
        path.join(SDL2_DIR, "src/audio/*.h"),
        path.join(SDL2_DIR, "src/audio/dummy/**"),
        -- EVENTS --
        path.join(SDL2_DIR, "src/events/*"),
        -- FILE --
        path.join(SDL2_DIR, "src/file/*.c"),
        -- HAPTIC --
        path.join(SDL2_DIR, "src/haptic/*.c"),
        path.join(SDL2_DIR, "src/haptic/*.h"),
        path.join(SDL2_DIR, "src/haptic/dummy/**"),
        -- joystick --
        path.join(SDL2_DIR, "src/joystick/*.c"),
        path.join(SDL2_DIR, "src/joystick/*.h"),
        path.join(SDL2_DIR, "src/joystick/dummy/**"),
        path.join(SDL2_DIR, "src/joystick/hidapi/*.c"),
        path.join(SDL2_DIR, "src/joystick/hidapi/*.h"),
        path.join(SDL2_DIR, "src/joystick/virtual/*"),
        -- LOCALE --
        path.join(SDL2_DIR, "src/locale/*.c"),
        path.join(SDL2_DIR, "src/locale/*.h"),
        path.join(SDL2_DIR, "src/locale/dummy/**"),
        -- POWER --
        path.join(SDL2_DIR, "src/power/*.c"),
        path.join(SDL2_DIR, "src/power/*.h"),
        -- RENDER --
        path.join(SDL2_DIR, "src/render/*.c"),
        path.join(SDL2_DIR, "src/render/*.h"),
        path.join(SDL2_DIR, "src/render/software/**"),
        path.join(SDL2_DIR, "src/render/opengl/**"),
        path.join(SDL2_DIR, "src/render/opengles2/**"),
        -- SENSOR --
        path.join(SDL2_DIR, "src/sensor/*.c"),
        path.join(SDL2_DIR, "src/sensor/*.h"),
        path.join(SDL2_DIR, "src/sensor/dummy/**"),
        -- THREAD --
        path.join(SDL2_DIR, "src/thread/*.c"),
        path.join(SDL2_DIR, "src/thread/*.h"),
        -- TIMER --
        path.join(SDL2_DIR, "src/timer/*.c"),
        path.join(SDL2_DIR, "src/timer/*.h"),
        path.join(SDL2_DIR, "src/timer/dummy/**"),
        -- VIDEO --
        path.join(SDL2_DIR, "src/video/*.c"),
        path.join(SDL2_DIR, "src/video/*.h"),
        path.join(SDL2_DIR, "src/video/dummy/**"),
        path.join(SDL2_DIR, "src/video/yuv2rgb/**"),
    }

    filter "system:windows"
        links { "setupapi", "winmm", "imm32", "version" }
        files {
            path.join(SDL2_DIR, "src/audio/directsound/**"),
            path.join(SDL2_DIR, "src/audio/disk/**"),
            path.join(SDL2_DIR, "src/audio/winmm/**"),
            path.join(SDL2_DIR, "src/audio/wasapi/**"),
            path.join(SDL2_DIR, "src/core/windows/**"),
            path.join(SDL2_DIR, "src/events/scancodes_windows.h"),
            path.join(SDL2_DIR, "src/filesystem/windows/**"),
            path.join(SDL2_DIR, "src/haptic/windows/**"),
            path.join(SDL2_DIR, "src/hidapi/windows/hid.c"),
            path.join(SDL2_DIR, "src/joystick/windows/**"),
            path.join(SDL2_DIR, "src/loadso/windows/**"),
            path.join(SDL2_DIR, "src/locale/windows/**"),
            path.join(SDL2_DIR, "src/power/windows/**"),
            path.join(SDL2_DIR, "src/render/direct3d/**"),
            path.join(SDL2_DIR, "src/render/direct3d11/**"),
            path.join(SDL2_DIR, "src/sensor/windows/**"),
            path.join(SDL2_DIR, "src/thread/generic/SDL_syscond.c"),
            path.join(SDL2_DIR, "src/thread/windows/**"),
            path.join(SDL2_DIR, "src/timer/windows/**"),
            path.join(SDL2_DIR, "src/video/windows/**"),
        }
        removefiles {
            "**/SDL_render_winrt.*"
        }
        defines {
            "SDL_DISABLE_WINDOWS_IME",
            "WIN32",
            "__WIN32__",
        }
        links { "user32", "gdi32", "winmm", "imm32", "ole32", "oleaut32", "version", "uuid" }

    filter "system:linux"
        files {
            path.join(SDL2_DIR, "src/core/windows/**"),
            path.join(SDL2_DIR, "src/events/scancodes_linux.h"),
            path.join(SDL2_DIR, "src/haptic/linux/**"),
            path.join(SDL2_DIR, "src/joystick/linux/**"),
            path.join(SDL2_DIR, "src/locale/unix/**"),
            path.join(SDL2_DIR, "src/power/linux/**"),
        }

    filter "system:macosx"
        includedirs { path.join(SDL2_DIR, "src/video/khronos") }
        xcodebuildsettings {
            ["ALWAYS_SEARCH_USER_PATHS"] = "YES",
        }
        files {
            path.join(SDL2_DIR, "src/audio/coreaudio/**"),
            path.join(SDL2_DIR, "src/audio/disk/**"),
            path.join(SDL2_DIR, "src/events/scancodes_darwin.h"),
            path.join(SDL2_DIR, "src/file/cocoa/**"),
            path.join(SDL2_DIR, "src/filesystem/cocoa/**"),
            path.join(SDL2_DIR, "src/haptic/darwin/**"),
            path.join(SDL2_DIR, "src/hidapi/*.c"),
            path.join(SDL2_DIR, "src/hidapi/hidapi/*.h"),
            path.join(SDL2_DIR, "src/hidapi/mac/*.c"),
            path.join(SDL2_DIR, "src/hidapi/ios/*.c"),
            path.join(SDL2_DIR, "src/joystick/darwin/**"),
            path.join(SDL2_DIR, "src/loadso/dlopen/**"),
            path.join(SDL2_DIR, "src/locale/macosx/**"),
            path.join(SDL2_DIR, "src/power/macosx/**"),
            path.join(SDL2_DIR, "src/render/opengles/**"),
            path.join(SDL2_DIR, "src/render/metal/**"),
            path.join(SDL2_DIR, "src/sensor/coremotion/**"),
            path.join(SDL2_DIR, "src/thread/pthread/**"),
            path.join(SDL2_DIR, "src/timer/unix/**"),
            path.join(SDL2_DIR, "src/video/cocoa/**"),
            path.join(SDL2_DIR, "src/video/khronos/**"),
            path.join(SDL2_DIR, "src/video/offscreen/**"),
            path.join(SDL2_DIR, "src/video/uikit/**"),
            path.join(SDL2_DIR, "src/video/x11/**"),
        }
        defines {
            "SDL_POWER_MACOSX",
            "SDL_VIDEO_DRIVER_COCOA",
            "SDL_VIDEO_OPENGL_GLX",
            "SDL_LOADSO_DLOPEN",
            "SDL_TIMER_UNIX",
            "SDL_FRAMEWORK_COCOA",
            "SDL_FRAMEWORK_CARBON",
            "SDL_FILESYSTEM_COCOA",
        }
        buildoptions {"-fPIC"}

    filter "system:android"
        files {
            path.join(SDL2_DIR, "src/audio/android/**"),
            path.join(SDL2_DIR, "src/audio/openslES/**"),
            path.join(SDL2_DIR, "src/core/android/**"),
            path.join(SDL2_DIR, "src/filesystem/android/**"),
            path.join(SDL2_DIR, "src/haptic/android/**"),
            path.join(SDL2_DIR, "src/hidapi/android/hid.cpp"),
            path.join(SDL2_DIR, "src/joystick/android/**"),
            path.join(SDL2_DIR, "src/locale/android/**"),
            path.join(SDL2_DIR, "src/power/android/**"),
            path.join(SDL2_DIR, "src/sensor/android/**"),
            path.join(SDL2_DIR, "src/video/android/**"),
            path.join(SDL2_DIR, "src/loadso/dlopen/**"),
            path.join(SDL2_DIR, "src/thread/pthread/**"),
            path.join(SDL2_DIR, "src/timer/unix/**"),
            path.join(SDL2_DIR, "src/render/opengles/**"),
        }

    filter "system:ios"
        files
        {
            path.join(SDL2_DIR, "src/joystick/iphoneos/**"),
        }

    filter "action:vs*"
        defines {
            "_CRT_SECURE_NO_WARNINGS",
            "VC_EXTRALEAN",
        }

project "sdl2_test_common"
    kind "StaticLib"
    files { path.join(SDL2_DIR, "src/test/**") }
    includedirs { SDL2_INCLUDE }

project "sdl2_main"
    kind "StaticLib"
    includedirs { SDL2_INCLUDE }

    filter "system:windows"
        files { SDL2_DIR.."src/main/windows/*.c" }

    filter "system:macosx"
        files { SDL2_DIR.."src/main/dummy/*.c" }

SDL2_TEST_DIR = path.join(SDL2_DIR, "test")

project "Test"
    kind "WindowedApp"
    links { "sdl2", "sdl2_test_common" }
    filter "system:windows"
        links { "sdl2_main" }
    files { 
        path.join(SDL2_DIR,"test/testsprite2.c"),
    }
    xcodebuildresources {
        path.join(SDL2_DIR, "test/*.bmp"),
    }
    includedirs { SDL2_INCLUDE }
    debugdir (SDL2_TEST_DIR)

    filter "system:macosx"
        links {
            "AudioToolbox.framework",
            "AudioUnit.framework",
            "Carbon.framework",
            "Cocoa.framework",
            "CoreAudio.framework",
            "CoreFoundation.framework",
            "CoreVideo.framework",
            "ForceFeedback.framework",
            "IOKit.framework",
            "Metal.framework",
            "dl" -- ?
        }