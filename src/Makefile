OUTPUTFILES = \
 ../default.css \
 ../index.html      \
 ../welcome.html  \
 ../news.html  \
 ../news_old.html  \
 ../faq.html      \
 ../contact.html      \
 ../download.html \
 ../screenshots.html \
 ../screenshots-0.0.html \
 ../screenshots-0.1.html \
 ../screenshots-0.2.html \
 ../screenshots-0.3.html \
 ../screenshots-0.4.html \
 ../screenshots-0.5.html \
 ../levelbuilding-tutorial.html \
 ../development.html \
 ../manual.html \
 ../press.html

all : $(OUTPUTFILES)

clean :
	rm -vf $(OUTPUTFILES)

../default.css : default.css
	cp -v $< $@

../index.html : index.html
	cp -v $< $@

../%.html :: %.xml default.xsl Makefile
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
