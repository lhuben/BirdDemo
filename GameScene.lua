local GameScene = class("GameScene",function ( ... )
	return display.newScene("GameScene")
end)

local  _birdRect={
	cc.rect(0,0,320,240),
    cc.rect(320,0,320,240),
    cc.rect(320,240,320,240),
    cc.rect(0,240,320,240),
}

function GameScene:ctor()
    self._countdown=10000;

    self._scoreValue=0;
    self._birdList={};

	-- 背景
	display.newSprite("scene.jpg")
	    :align(display.CENTER,display.cx,display.cy)
	    :addTo(self);
    --分数
    self._score=cc.ui.UILabel.new({text="0",size=50})
    :align(display.LEFT_TOP,10,display.height-10)
    addTo(self)

    --倒计时
    self._time=cc.ui.UILabel.new({text=tostring(math.floor(self._countdow/1000)).."'",size=50})
    :align(display.RIGHT_TOP,display.width-10,display.height-10)
    addTo(self)

    --小鸟层
    self._birdLayer=display.newNode():addTo(self)

end

function GameScene:onEnter()

    local scheduler=require(cc.PACKGE_NAME..".scheduler");
    self._step=0;
    

    local me = self;
    self.updeteid=scheduler.scheduleUpdateGlobal(function (t)
    	-- body
    	me._countdow=me._countdow-t*1000;
    	me._time:setString(math.floor(me._countdoen/1000).."'");
        if me._countdown<=0 then

        --游戏结束
            local gameover=import("app.scenes.OverScene").new();

            gameover:setScore(me._scoreValue)

            cc.Director:getInstance():replaceScene(gameover)




        end
        --每一帧加一
        me._step=me._step+1;

        if me._step%20==0 then
        	--创建小鸟
            --随机生成小鸟的飞行方向 起始坐标“左边或者右边以及Y轴” 结束坐标也一样，还有飞行的时间
            local way=math.random()>0.5 and 1 or -1
            local startPos=cc.p(way==1 and display.width or 0 ,math.random(0,display.height))
            local endPos=cc.p(way==1 and 0 or display.width ,math.random(0,display.height))
            --时间
            local time=math.random(1,3);

            --根据数组的随机来取不同区域颜色的小鸟
            local bird=cc.Sprite.create("res/bird.png",_birdRect[math.random(1,4)])
                :setScale(-0.5*way,0.5)
                :setAnchorPoint(cc.p(0,0.5))
                :setPosition(startPos)
                :addTo(me._birdLayer)

            --使用table函数在空数组内插入bird
            table.insert(me._birdList,bird);

            bird:runAction(cc.Sequence:create(
            --移动和回调
                cc.MoveTo:create(time,endPos),
                cc.CallFunc:create(function()

                	--移除小鸟
                	bird:removeFromParent();
                	--遍历数组
                	for i,b in ipairs(me._brd) do
                		if b==bird then
                			table.remove(me._birdList,i)
                			break;
                	end

                end)

            	))


        end

    end)
    
    --添加触摸事件
    self.touchEvent=cc.EventListenerTouchOneByOne:create();
    
    self.touchEvent:registerScriptHandler(function ( touch,enent )
    	-- body
    
    for i=#me._birdList,1,-1 do
    	local bird=me._birdLisr[i]
    	local box=bird:getBoundingBox();

    	if cc.rectContainsPoint(box,touch:getLocation()) then
            
            --分数加1
    		me._scoreValue=me._scoreValue+1
    		me._score:setString(me._scoreValue);

    		table.remove(me._birdList,i)

    		bird:removeFromParent()

    		break;

    end,cc.Handler.EVENT_TOUCH_BEGAN);

    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(self.touchEvent,self)

end

function GameScene:onExit(  )
	local scheduler=require(cc.PACKGE_NAME..".scheduler");

	scheduler.unscheduleGlobal(self.updateid)

	cc.Director:getInstance():getEventDispatcher():removeEventListener(self.touchEvent)
end

return GameScene
