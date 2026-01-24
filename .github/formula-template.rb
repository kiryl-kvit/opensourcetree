class Opensourcetree < Formula
  desc "Cross-platform Git GUI application"
  homepage "https://github.com/kiryl-kvit/opensourcetree"
  version "VERSION_PLACEHOLDER"
  license "MIT"

  on_linux do
    on_intel do
      url "https://github.com/kiryl-kvit/opensourcetree/releases/download/vVERSION_PLACEHOLDER/opensourcetree-VERSION_PLACEHOLDER-linux-x64.tar.gz"
      sha256 "LINUX_SHA_PLACEHOLDER"
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/kiryl-kvit/opensourcetree/releases/download/vVERSION_PLACEHOLDER/opensourcetree-VERSION_PLACEHOLDER-osx-arm64.tar.gz"
      sha256 "MACOS_SHA_PLACEHOLDER"
    end
  end

  def install
    if OS.mac?
      prefix.install "OpenSourceTree.app"
      (bin/"opensourcetree").write <<~SH
        #!/bin/bash
        open "#{prefix}/OpenSourceTree.app" "$@"
      SH
    else
      bin.install "opensourcetree"

      # Install .desktop file to the Homebrew share directory for desktop integration
      desktop_dir = share/"applications"
      desktop_dir.mkpath
      desktop_file = desktop_dir/"opensourcetree.desktop"
      desktop_file.write <<~DESKTOP
        [Desktop Entry]
        Name=OpenSourceTree
        GenericName=Git Client
        Comment=Cross-platform Git GUI application
        Exec=#{opt_bin}/opensourcetree %F
        Icon=opensourcetree
        Terminal=false
        Type=Application
        Categories=Development;RevisionControl;
        Keywords=git;version control;vcs;repository;
        StartupWMClass=OpenSourceTree
        MimeType=application/x-git;
      DESKTOP

      # Install icon to the Homebrew share directory for desktop integration
      icon_dir = share/"icons/hicolor/scalable/apps"
      icon_dir.mkpath
      (icon_dir/"opensourcetree.svg").write(File.read("opensourcetree.svg"))
    end
  end

  def caveats
    if OS.mac?
      <<~EOS
        To add OpenSourceTree to your Applications folder:
          ln -sf #{prefix}/OpenSourceTree.app /Applications/OpenSourceTree.app

        Then it will appear in Spotlight search.
      EOS
    else
      <<~EOS
        Desktop integration files have been installed to:
          #{share}/applications/opensourcetree.desktop
          #{share}/icons/hicolor/scalable/apps/opensourcetree.svg

        If your launcher does not pick it up - ln -s $(brew --prefix)/share/applications/opensourcetree.desktop ~/.local/share/applications.
      EOS
    end
  end

  test do
    assert_predicate bin/"opensourcetree", :exist?
  end
end
