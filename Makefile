none: help

help:
	@echo "=== CalikoCat 1.0 ==="
	@echo "Select a build target:"
	@echo "  make ready         Build CalikoCat and bundles it for distribution."
	@echo "  make clean         Clean up CalikoCat and Tester."
	@echo "  make cleandebug    Clean up CalikoCat and Tester Debug."
	@echo "  make cleanrelease  Clean up CalikoCat and Tester Release."
	@echo "  make docs          Generate HTML docs."
	@echo "  make docs_pdf      Generate PDF docs."
	@echo "  make calikocat        Build CalikoCat as release."
	@echo "  make calikocat_debug  Build CalikoCat as debug."
	@echo "  make tester        Build CalikoCat Tester (+CalikoCat) as release."
	@echo "  make tester_debug  Build CalikoCat Tester (+CalikoCat) as debug."
	@echo "  make all           Build everything."
	@echo "  make allfresh      Clean and rebuild everything."
	@echo
	@echo "Clang Sanitizers (requires Debug build and Clang.)"
	@echo "  SAN=address     Use AddressSanitizer"
	@echo "  SAN=leak        Use LeakSanitizer w/o AddressSanitizer (Linux only)"
	@echo "  SAN=memory      Use MemorySanitizer"
	@echo "  SAN=thread      Use ThreadSanitizer"
	@echo "  SAN=undefined   Use UndefiniedBehaviorSanitizer"
	@echo
	@echo "Optional Architecture"
	@echo "  ARCH=32         Make x86 build (-m32)"
	@echo "  ARCH=64         Make x64 build (-m64)"
	@echo
	@echo "Use Configuration File"
	@echo "  CONFIG=foo      Uses the configuration file 'foo.config'"
	@echo "                  in the root of this repository."
	@echo "  When unspecified, default.config will be used."
	@echo
	@echo "For other build options, see the 'make' command in 'docs/', 'calikocat-source/', 'calikocat-tester/', and 'cpgf/build/'."

clean:
	$(MAKE) clean -C calikocat-source
	$(MAKE) clean -C calikocat-tester

cleanall: clean
	$(MAKE) clean -C docs

cleandebug:
	$(MAKE) cleandebug -C calikocat-source
	$(MAKE) cleandebug -C calikocat-tester

cleanrelease:
	$(MAKE) cleanrelease -C calikocat-source
	$(MAKE) cleanrelease -C calikocat-tester

docs:
	$(MAKE) html -C docs
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "View docs at 'docs/build/html/index.html'."
	@echo "-------------"

docs_pdf:
	$(MAKE) latexpdf -C docs
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "View docs at 'docs/build/latex/CalikoCat.pdf'."
	@echo "-------------"

calikocat:
	$(MAKE) release ARCH=$(ARCH) CONFIG=$(CONFIG) -C calikocat-source
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "CalikoCat is in 'calikocat-source/lib/Release'."
	@echo "-------------"

calikocat_debug:
	$(MAKE) debug ARCH=$(ARCH) CONFIG=$(CONFIG) SAN=$(SAN) -C calikocat-source
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo  on "CalikoCat is in 'calikocat-source/lib/Debug'."
	@echo "-------------"

ready: calikocat
	@rm -rf calikocat
	@echo "Creating file structure..."
	@mkdir -p calikocat/lib
	@echo "Copying CalikoCat..."
	@cp -r calikocat-source/include calikocat/
	@cp calikocat-source/lib/Release/libcalikocat.a calikocat/lib/libcalikocat.a
	@echo "Copying README and LICENSE..."
	@cp README.md calikocat/README.md
	@cp LICENSE.md calikocat/LICENSE.md
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "The libraries are in 'calikocat'."
	@echo "-------------"

tester: calikocat
	$(MAKE) release ARCH=$(ARCH) CONFIG=$(CONFIG) -C calikocat-tester
	@rm -f tester
	@ln -s calikocat-tester/bin/Release/calikocat-tester tester
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "CalikoCat Tester is in 'calikocat-tester/bin/Release'."
	@echo "The link './tester' has been created for convenience."
	@echo "-------------"


tester_debug: calikocat_debug
	$(MAKE) debug ARCH=$(ARCH) CONFIG=$(CONFIG) SAN=$(SAN) -C calikocat-tester
	@rm -f tester_debug
	@ln -s calikocat-tester/bin/Debug/calikocat-tester tester_debug
	@echo "-------------"
	@echo "<<<<<<< FINISHED >>>>>>>"
	@echo "CalikoCat Tester is in 'calikocat-tester/bin/Debug'."
	@echo "The link './tester_debug' has been created for convenience."
	@echo "-------------"

all: docs tester

allfresh: cleanall all

.PHONY: all allfresh clean cleanall cleandebug cleanrelease docs docs_pdf calikocat calikocat_debug ready tester tester_debug
