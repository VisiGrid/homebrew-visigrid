# typed: false
# frozen_string_literal: true

class Visigrid < Formula
  desc "The spreadsheet that behaves like code"
  homepage "https://visigrid.app"
  version "0.5.3"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/VisiGrid/VisiGrid/releases/download/v#{version}/VisiGrid-macOS-universal.dmg"
      sha256 "e52e784671637cb85331dd054b42b043bdceaa56e55b3e2fc082116313cd5908"
    else
      url "https://github.com/VisiGrid/VisiGrid/releases/download/v#{version}/VisiGrid-macOS-universal.dmg"
      sha256 "e52e784671637cb85331dd054b42b043bdceaa56e55b3e2fc082116313cd5908"
    end
  end

  on_linux do
    url "https://github.com/VisiGrid/VisiGrid/releases/download/v#{version}/VisiGrid-linux-x86_64.tar.gz"
    sha256 "1a42a4e0485ad1b2487de30d02402e1da98636a89bc11b972acbe0894e6845ac"
  end

  def install
    if OS.mac?
      # Extract app from DMG and install
      prefix.install "VisiGrid.app"
      bin.write_exec_script "#{prefix}/VisiGrid.app/Contents/MacOS/visigrid"
      bin.write_exec_script "#{prefix}/VisiGrid.app/Contents/MacOS/visigrid-cli"
    else
      bin.install "visigrid"
      bin.install "visigrid-cli"
    end
  end

  def caveats
    if OS.mac?
      <<~EOS
        VisiGrid.app has been installed to:
          #{prefix}/VisiGrid.app

        To open VisiGrid from the command line:
          visigrid

        To use the CLI tools:
          visigrid-cli --help
      EOS
    end
  end

  test do
    assert_match "visigrid-cli", shell_output("#{bin}/visigrid-cli --version")
  end
end
