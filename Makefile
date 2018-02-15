TEMPLATE=cpp -w -undef -nostdinc -E -P
MARKDOWN=pandoc --template pandoc_template.txt -f markdown -t html --katex --toc
SHARED=common-header.t.html common-footer.t.html css/style.css

all: index.html \
	 posts/rust-speed.html \
	 posts/rust-vs-go.html \
	 posts/webassembly.html \
	 posts/hetero-queue.html \
	 posts/implicit.html \
	 posts/bincode_release.html

tmp:
	mkdir tmp

tmp/rust-speed.md.html: posts/rust-speed.md tmp
	$(MARKDOWN) $< > $@

tmp/hetero-queue.md.html: posts/hetero-queue.md tmp
	$(MARKDOWN) $< > $@

tmp/webassembly.md.html: posts/webassembly.md tmp
	$(MARKDOWN) $< > $@

tmp/index.md.html: index.md tmp
	$(MARKDOWN) $< > $@

tmp/implicit.md.html: posts/implicit.md tmp
	$(MARKDOWN) $< > $@

tmp/bincode_release.md.html: posts/bincode_release.md tmp
	$(MARKDOWN) $< > $@

tmp/rust-vs-go.md.html: posts/rust-vs-go.md tmp
	$(MARKDOWN) $< > $@

posts/rust-speed.html: tmp/rust-speed.md.html $(SHARED)
	$(TEMPLATE) \
		"-D KATEX" \
		"-D TITLE=Rust Speed" \
		"-D SUBTITLE=Turns Out It's Pretty Fast" \
		"-D HEADER_IMAGE_PATH=../images/waves.jpg" \
		"-D HEADER_STYLE=white" \
		"-D POST=\"./tmp/rust-speed.md.html\"" \
		post.t.html > posts/rust-speed.html

posts/hetero-queue.html: tmp/hetero-queue.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Heterogeneous Lists" \
		"-D SUBTITLE=And How To Make Them" \
		"-D HEADER_IMAGE_PATH=../images/dark-field.jpeg" \
		"-D HEADER_STYLE=white" \
		"-D POST=\"./tmp/hetero-queue.md.html\"" \
		post.t.html > posts/hetero-queue.html

posts/rust-vs-go.html: tmp/rust-vs-go.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Error Handling in Rust and Go" \
		"-D SUBTITLE=Products and Sums" \
		"-D HEADER_IMAGE_PATH=../images/city.jpg" \
		"-D HEADER_STYLE=white" \
		"-D POST=\"./tmp/rust-vs-go.md.html\"" \
		post.t.html > posts/rust-vs-go.html

posts/webassembly.html: tmp/webassembly.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Web Assembly" \
		"-D SUBTITLE=The Future Is Here, Shiny And Chrome" \
		"-D HEADER_IMAGE_PATH=../images/snowy-mountains.jpeg" \
		"-D HEADER_STYLE=black" \
		"-D POST=\"./tmp/webassembly.md.html\"" \
		post.t.html > posts/webassembly.html

posts/bincode_release.html: tmp/bincode_release.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Bincode 1.0.0" \
		"-D SUBTITLE=Fucking Finally" \
		"-D HEADER_IMAGE_PATH=../images/snowy-mountains.jpeg" \
		"-D HEADER_STYLE=black" \
		"-D POST=\"./tmp/bincode_release.md.html\"" \
		post.t.html > posts/bincode_release.html

posts/implicit.html: tmp/implicit.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Implicit CAD" \
		"-D SUBTITLE=A Better Way to Shape" \
		"-D HEADER_IMAGE_PATH=../images/foam.jpeg" \
		"-D HEADER_STYLE=white" \
		"-D POST=\"./tmp/implicit.md.html\"" \
		post.t.html > posts/implicit.html


index.html: tmp/index.md.html $(SHARED)
	$(TEMPLATE) \
		"-D TITLE=Ty Overby" \
		"-D SUBTITLE=" \
		"-D HEADER_IMAGE_PATH=./images/snowy-mountains.jpeg" \
		"-D HEADER_STYLE=black" \
		"-D POST=\"./tmp/index.md.html\"" \
		post.t.html > index.html

clean:
	rm index.html
	rm -rf tmp/
	rm posts/*.html
