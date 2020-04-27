.PHONY: linux
linux : linux.dhall
	dhall-to-yaml --file linux.dhall

.PHONY: linux_test
linux_test : linux_test.dhall
	dhall-to-yaml --file linux_test.dhall

.PHONY: linux_test_keys
linux_test_keys : linux_test_keys.dhall
	dhall-to-yaml --file linux_test_keys.dhall

.PHONY: macos
macos : macos.dhall
	dhall-to-yaml --file macos.dhall

.PHONY: windows
windows : windows.dhall
	dhall-to-yaml --file windows.dhall
