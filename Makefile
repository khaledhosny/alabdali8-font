NAME=AlAbdali8
VERSION=002.001

FF=fontforge -lang=ff
FFLAGES=0x200000
SCRIPT='Open($$1); MergeFeature($$2); SetFontNames("","","","","","$(VERSION)"); Generate($$3, "", $(FFLAGES))'

all: $(NAME).otf

$(NAME).otf : $(NAME).sfd $(NAME).fea
	@echo "Generating $@"
	@$(FF) -c $(SCRIPT) $^ $@ 2>/dev/stdout 1>/dev/stderr | tail -n +4

dist: $(NAME).otf
	@echo "Making dist tarball"
	@mkdir -p $(NAME)-$(VERSION)
	@cp $(NAME).otf $(NAME).sfd $(NAME).fea $(NAME)-$(VERSION)
	@cp Makefile $(NAME)-$(VERSION)
	@cp README $(NAME)-$(VERSION)
	@zip -r $(NAME)-$(VERSION).zip $(NAME)-$(VERSION)

clean:
	@rm -rf $(NAME).otf $(NAME)-$(VERSION) $(NAME)-$(VERSION).zip
