NAME=AlAbdali8
VERSION=002.001

PY=python

define $(NAME)SCRIPT
import fontforge, sys
f = fontforge.open(sys.argv[1])
if len(sys.argv) > 3:
  f.mergeFeature(sys.argv[3])
f.version = "$(VERSION)"
f.generate(sys.argv[2], flags=("round", "opentype"))
endef

export $(NAME)SCRIPT

all: $(NAME).otf

$(NAME).otf : $(NAME).sfd $(NAME).fea
	@echo "Building $@"
	@$(PY) -c "$$$(NAME)SCRIPT" $< $@ $(NAME).fea

dist: $(NAME).otf
	@echo "Making dist tarball"
	@mkdir -p $(NAME)-$(VERSION)
	@cp $(NAME).otf $(NAME).sfd $(NAME).fea $(NAME)-$(VERSION)
	@cp Makefile $(NAME)-$(VERSION)
	@cp README $(NAME)-$(VERSION)
	@zip -r $(NAME)-$(VERSION).zip $(NAME)-$(VERSION)

clean:
	@rm -rf $(NAME).otf $(NAME)-$(VERSION) $(NAME)-$(VERSION).zip
