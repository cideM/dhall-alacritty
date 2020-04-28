.PHONY: linux
linux : linux.dhall
	dhall-to-yaml --file linux.dhall

.PHONY: tests
tests : tests.dhall
	dhall-to-yaml --file tests.dhall

.PHONY: macos
macos : macos.dhall
	dhall-to-yaml --file macos.dhall

.PHONY: windows
windows : windows.dhall
	dhall-to-yaml --file windows.dhall
