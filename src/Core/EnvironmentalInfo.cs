using System.Runtime.InteropServices;

namespace Core;

public sealed record EnvironmentReport(
    string TargetFramework,
    string OsDescription,
    string FrameworkDescription,
    string ProcessArchitecture,
    string DetectedRid,
    string ReportedRid,
    string BaseDirectory);

public static class EnvironmentInfo
{
    public static EnvironmentReport Collect() => new(
        GetTargetVersion(),
        RuntimeInformation.OSDescription,
        RuntimeInformation.FrameworkDescription,
        RuntimeInformation.ProcessArchitecture.ToString(),
        DetectRid(),
        RuntimeInformation.RuntimeIdentifier,
        AppContext.BaseDirectory);

    private static string GetTargetVersion()
    {
#if NET10_0
        return ".NET 10";
#elif NET8_0
        return ".NET 8";
#else
        return "Other Framework";
#endif
    }

    private static string DetectRid()
    {
        var os =
            RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? "win" :
            RuntimeInformation.IsOSPlatform(OSPlatform.Linux) ? "linux" :
            RuntimeInformation.IsOSPlatform(OSPlatform.OSX) ? "osx" : "unknown";

        var arch = RuntimeInformation.ProcessArchitecture switch
        {
            Architecture.X64 => "x64",
            Architecture.X86 => "x86",
            Architecture.Arm64 => "arm64",
            Architecture.Arm => "arm",
            _ => "unknown"
        };

        return $"{os}-{arch}";
    }
}