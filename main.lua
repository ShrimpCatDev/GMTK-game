require("init")

function love.load()
    font=lg.newFont("assets/font/monogram-extended.ttf",16)
    lg.setFont(font)
    shove.createLayer("game")
    print("hi lol")

    bar={w=150,h=8,x=1,y=1,
    sel={x=0,spd=120,w=3,dx=0},
        sweet={x=0,w=16,dx=0,dw=16,hp=1}
    }
    bar.sel.x=bar.w-3
    bar.x=conf.gW/2-bar.w/2
    bar.y=conf.gH-8-3
    score=0
    combo=0
    colors={
        {0,1,1},
        {1,1,0},
        {1,0,0}
    }
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

function love.update(dt)
    input:update()
    bar.sel.x=bar.sel.x-bar.sel.spd*dt
    local i=input:pressed("a")
    local c=bar.sweet.x<=(bar.sel.x+bar.sel.w) and bar.sweet.x+bar.sweet.w>=bar.sel.x
    if i then
        bar.sel.x=bar.w-3
        bar.sweet.x=math.random(0,bar.w-56)
        bar.sweet.w=math.random(10,32)
        --bar.sweet.hp=math.random(1,3)
        if c then
            score=score+1
            combo=combo+1
        else
            combo=0
        end
    end
    if bar.sel.x<0 then
        bar.sel.x=bar.sel.x+bar.w-3
        combo=0
    end
    bar.sweet.dx=lerp(bar.sweet.dx,bar.sweet.x,10*dt)
    bar.sweet.dw=lerp(bar.sweet.dw,bar.sweet.w,8*dt)
end 

function love.draw()
    beginDraw()
        lg.setColor(0,0,1)
        lg.rectangle("fill",bar.x,bar.y+1,bar.w,bar.h-2,2)
        lg.setColor(0,1,1)
        lg.rectangle("fill",bar.x+bar.sweet.dx,bar.y+1,bar.sweet.dw,bar.h-2,2)
        lg.setColor(1,1,1)
        lg.rectangle("fill",bar.x+bar.sel.x,bar.y,bar.sel.w,bar.h)
        lg.setColor(1,1,1)
        lg.print("Score: "..score,1,1)
        lg.print("Combo x "..combo,1,13)
    endDraw()
end
