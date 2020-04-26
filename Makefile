.PHONY: linux
linux : linux.dhall
	dhall type --file linux.dhall

.PHONY: linux_test
linux_test : linux_test.dhall
	dhall type --file linux_test.dhall

.PHONY: macos
macos : macos.dhall
	dhall type --file macos.dhall

.PHONY: windows
windows : windows.dhall
	dhall type --file windows.dhall
