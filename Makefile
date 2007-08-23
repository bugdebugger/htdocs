OUTPUTFILES = \
 build/default.css \
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
 build/levelbuilding-tutorial.html \
 build/development.html \
 build/manual.html \
 build/press.html

.PHONY : images

all : $(OUTPUTFILES)
	mkdir -p build/

images :
	mkdir -p build/images/
	cp -v images/*.png build/images/
	cp -v images/*.jpg build/images/

clean :
	rm -vf $(OUTPUTFILES)

build/default.css : default.css
	cp -v $< $@

build/index.html : index.html
	cp -v $< $@

build/%.html :: %.xml default.xsl Makefile
	FILENAME=$<; \
	echo $${FILENAME%%.xml}; \
	xalan -param filename "'$${FILENAME%%.xml}'" -in $< -out $@ -xsl default.xsl

upload: all
	(cd ..; \
	rsync --checksum --exclude "old/" --cvs-exclude -rv . \
          grumbel@pingus.seul.org:/home/pingus/public_html/ \
	)

commit: all
	(cd ..; \
	cvs commit -m "automatic commit" )

#tidy -asxml -indent -quiet -modify $@

.PHONY: all clean upload

# EOF #
