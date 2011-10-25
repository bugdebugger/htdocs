OUTPUTFILES = \
 build/default.css \
 build/desert.css \
 build/halloween.css \
 build/snow.css \
 build/index.html      \
 build/welcome.html  \
 build/news.html  \
 build/news_old.html  \
 build/faq.html      \
 build/contact.html      \
 build/download.html \
 build/screenshots.html \
 build/screenshots-0.0.html \
 build/screenshots-0.1.html \
 build/screenshots-0.2.html \
 build/screenshots-0.3.html \
 build/screenshots-0.4.html \
 build/screenshots-0.5.html \
 build/screenshots-0.6.html \
 build/videos.html \
 build/levelbuilding-tutorial.html \
 build/development.html \
 build/manual.html \
 build/links.html


all : build $(OUTPUTFILES) images

build:
	mkdir -p build/

images :
	rsync -rCtluv images/ build/images/

clean :
	rm -vf $(OUTPUTFILES)

build/default.css : default.css default.css.sed compatibility.sed
	sed -f "compatibility.sed" -f "default.css.sed" $< > $@

build/snow.css : default.css default.css.sed compatibility.sed
	sed -f "compatibility.sed" -f "default.css.sed" $< > $@

build/desert.css : default.css desert.css.sed compatibility.sed
	sed -f "compatibility.sed" -f "desert.css.sed" $< > $@

build/halloween.css : default.css halloween.css.sed compatibility.sed
	sed -f "compatibility.sed" -f "halloween.css.sed" $< > $@

build/index.html : index.html
	cp -v $< $@

build/%.html :: %.xml default.xsl Makefile
	@echo "----------------------------------------------------------------------------"
	FILENAME=$<; \
	echo $${FILENAME%%.xml}; \
	xsltproc -param filename "'$${FILENAME%%.xml}'" --output $@ default.xsl $<
	sed -i 's/<!DOCTYPE html PUBLIC "XSLT-compat">/<!DOCTYPE html>/' $@
	# sed -i 's/<!DOCTYPE html PUBLIC "XSLT-compat" "">/<!DOCTYPE html>/' $@
	# tidy -modify -indent -wrap 1000 -quiet -ashtml $@ || (if [ $$? -eq 2 ]; then rm -v $@; exit 1; fi)

upload: all
	rsync --checksum --exclude "old/" --cvs-exclude -rv build/ \
          grumbel@pingus.seul.org:/home/pingus/public_html/

#tidy -asxml -indent -quiet -modify $@

.PHONY: all clean upload images

# EOF #
