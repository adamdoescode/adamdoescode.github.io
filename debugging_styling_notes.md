Trying to add mobile styling but it's not working.

Instead adding the meta viewport tag makes the page not fit the screen.

Let's debug.

Elimination of elements to see if can make it fit:
- [x] media font size change - no, but helps
- [x] all images - no
- [x] DecorativeElement - no
- [x] aboutSection - no
- [x] projectSection - no? Somehow the screen is now *wider* even tho there is no content...
- [x] footer - no
- [x] title - no

Okay so deleting ALL of the above (sans foot) does nothing??!

So it's one of the left over divs... what is left:
    <div class="parentDiv">
        <div class="spacer"></div>
        <div class="mainTextContainer">
            <div class="pageHeader">

Okay so uncommented everything...

- [x] spacers - no
- [ ] parentDiv - yes
- [ ] mainTextContainer - yes (with parentDiv restored)
- [ ] pageHeader - no

Okay so the problem is the `parentDiv`.

Changing flex-shrink 0 to 1 helps... still a little too wide

Ensuring spacer width: 0px doesnt help either.

**i think this worked in the end**

- set viewport meta to `initial-scale=0.8`
- adjust the h1 so that on small screens it behaves differently



