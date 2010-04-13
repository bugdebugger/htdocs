OUTPUTFILES = \
 build/default.css \
 build/desert.css \
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

.PHONY : images

all : $(OUTPUTFILES)
	mkdir -p build/

images :
	mkdir -p build/images/
	cp -v images/*.png build/images/
	cp -v images/*.jpg build/images/

clean :
	rm -vf $(OUTPUTFILES)

build/default.css : default.css default.css.sed
	sed -f "default.css.sed" $< > $@

build/snow.css : default.css default.css.sed
	sed -f "default.css.sed" $< > $@

build/desert.css : default.css desert.css.sed
	sed -f "desert.css.sed" $< > $@

build/index.html : index.html
	cp -v $< $@

build/%.html :: %.xml default.xsl Makefile
	@echo "----------------------------------------------------------------------------"
	FILENAME=$<; \
	echo $${FILENAME%%.xml}; \
	xsltproc -param filename "'$${FILENAME%%.xml}'" --output $@ default.xsl $<
	# tidy -modify -quiet -ashtml $@

upload: all
	rsync --checksum --exclude "old/" --cvs-exclude -rv build/ \
          grumbel@pingus.seul.org:/home/pingus/public_html/

#tidy -asxml -indent -quiet -modify $@

.PHONY: all clean upload

# EOF #
