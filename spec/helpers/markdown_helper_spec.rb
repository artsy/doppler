require "spec_helper"

describe MarkdownHelper do
  subject do
    Class.new do
      extend MarkdownHelper
    end
  end
  context "#render_markdown" do
    it "minimal document" do
      expect(subject.render_markdown("")).to eq ""
      expect(subject.render_markdown("hello world")).to eq "<p>hello world</p>\n"
    end
    it "table markup" do
      expect(subject.render_markdown(<<~TEXT
         x | y |
        --:|:--|
         a | b |
      TEXT
                                    )).to start_with '<table class="table table-bordered table-striped">'
    end
    it "code markup" do
      expect(subject.render_markdown(<<~TEXT
        ```
        code
        ```
      TEXT
                                    )).to eq "<pre><code>code\n</code></pre>\n"
    end
    it "ruby markup" do
      expect(subject.render_markdown(<<~TEXT
        ``` ruby
        x = y
        ```
      TEXT
                                    )).to eq "<div class=\"CodeRay\">\n  <div class=\"code\"><pre>x = y</pre></div>\n</div>\n"
    end
    it "alert markup" do
      expect(subject.render_markdown(<<~TEXT
        ``` alert[warning]
        WARNING!
        ```
      TEXT
                                    )).to eq "<div class=\"alert alert-warning\">\n<p>WARNING!</p>\n</div>\n"
    end
    it "alert markup with markdown" do
      expect(subject.render_markdown(<<~TEXT
        ``` alert[warning]
        [docs](/docs)
        ```
      TEXT
                                    )).to eq "<div class=\"alert alert-warning\">\n<p><a href=\"/docs\">docs</a></p>\n</div>\n"
    end
  end
end
