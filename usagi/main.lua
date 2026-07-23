gw=160
gh=144

function _config()
  ---@type Usagi.Config
  return { name = "Game", game_id = "com.usagiengine.YOURGAMENAME", game_width=160,game_height=144}
  
end

function _init()
  -- Live reload preserves globals across saved edits but resets locals.
  -- Stash mutable game state in a capitalized global like `State` so it
  -- survives reloads; F5 calls _init again to reset.
  State = {}
  bar={w=150,h=8,x=1,y=1,
    sel={x=0,spd=120,w=3,dx=0},
    sweet={x=0,w=16,dx=0,dw=16}
  }
  bar.sel.x=bar.w-3
  bar.x=gw/2-bar.w/2
  bar.y=gh-8-3
  score=0
end

function _update(dt)
  bar.sel.x-=bar.sel.spd*dt
  if (input.pressed(input.BTN1) and bar.sweet.x<=(bar.sel.x+bar.sel.w) and bar.sweet.x+bar.sweet.w>=bar.sel.x) then
    bar.sel.x=bar.w-3
    bar.sweet.x=math.random(0,bar.w-56)
    bar.sweet.w=math.random(10,32)
    score+=1
  end
  if bar.sel.x<0 then
    bar.sel.x=bar.w-3
  end
  bar.sweet.dx=util.lerp(bar.sweet.dx,bar.sweet.x,10*dt)
  bar.sweet.dw=util.lerp(bar.sweet.dw,bar.sweet.w,8*dt)
end

function _draw(dt)
  gfx.clear(gfx.COLOR_BLACK)
  gfx.rect_fill(bar.x,bar.y+1,bar.w,bar.h-2,3)
  gfx.rect_fill(bar.x+bar.sweet.dx,bar.y+1,bar.sweet.dw,bar.h-2,4)
  gfx.rect_fill(bar.x+bar.sel.x,bar.y,bar.sel.w,bar.h,8)
  gfx.text("Score: "..score,1,1,8)
end
