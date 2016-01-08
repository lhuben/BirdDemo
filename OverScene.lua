local OverScene = class("OverScene",function ( ... )
	return display.newScene("OverScene")
end)

function OverScene:ctor()
	-- 背景
	display.newSprite("scene.jpg")
	    :align(display.CENTER,display.cx,display.cy)
	    :addTo(self);

	--分数   
    self._score=cc.ui.UILabel.new({text="0",size=50})
    :align(display.CENTER,display.cx,display.cy+100)
    addTo(self)

    --弹出场景
	cc.ui.UIPushButton.new("res/continue.png")
	    :align(display.CENTER,display.cx,display.cy-100)
	    :addTo(self):addButtonClickEventListener(function ()
	        cc.Director:gerInstance():popScene();

	    end);
end

function  OverScene:setScore(value)
	self._score:setSring(value)
	-- body
end

function OverScene:onEnter()
end

function OverScene:onExit(  )
	
end

return OverScene
