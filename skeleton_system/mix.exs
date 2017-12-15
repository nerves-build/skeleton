defmodule SkeletonSystem.Mixfile do
  use Mix.Project

  @version Path.join(__DIR__, "VERSION")
    |> File.read!
    |> String.trim

  def project do
    [
      app: :skeleton_system,
      version: @version,
      elixir: "~> 1.4",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: ["deps.precompile": ["nerves.env", "deps.precompile"]]
    ]
  end

  def application do
    []
  end

  def nerves_package do
    [
      type: :system,
#      artifact_url: [
#        "https://github.com/nerves-project/#{@app}/releases/download/v#{@version}/#{@app}-v#{@version}.tar.gz"
#      ],
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 0.8", runtime: false },
      {:nerves_system_br, "0.16.0-2017-11", runtime: false},
      {:nerves_toolchain_armv6_rpi_linux_gnueabi, "~> 0.12.1", runtime: false},
      {:nerves_system_linter, "~> 0.2.2", runtime: false}
    ]
  end

  defp description do
    """
    Skeleton System - Sample system including Python and Numpy support
    """
  end

  defp package do
    [
      maintainers: ["Steven Fuchs"],
      files: package_files(),
      licenses: ["Apache 2.0"],
    ]
  end

  defp package_files do
    [
      "LICENSE",
      "mix.exs",
      "nerves_defconfig",
      "README.md",
      "VERSION",
      "rootfs_overlay",
      "fwup.conf",
      "cmdline.txt",
      "linux-4.4.defconfig",
      "config.txt",
      "post-createfs.sh"
    ]
  end
end
