Advanced Rspec

mike.frawley@space150.com

http://github.com/ratbeard/presentations
-------------------0
Overview:

0. intro
1. matchers
2. let / subject
3. context
4. misc

-------------------0
why rspec?

- popular
- really emphasizes readability
- newer features for concise, expressive specs

-------------------0
# Easier to read assertion order

# test - expected - actual
assert_equal 3, [5, 6, 7].size

# actual - test - expected
[5, 6, 7].size.should == 3