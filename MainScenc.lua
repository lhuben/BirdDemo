local MainScenc = class("MainScenc",function ( ... )
	return display.newScene("MainScenc")
end)

function MainScenc:ctor()
	-- 背景
	display.newSprite("scene.jpg")
	    :align(display.CENTER,display.cx,display.cy)
	    :addTo(self);

	    cc.ui.UIPushButton.new("res/start.png")
	        :align(display.CENTER,display.cx,display.cy)
	        :addTo(self):addButtonClickEventListener(function ()
	        	-- body
	        	cc.Director:getInstance():pushScene(import("app.scenes.GameScene").new());
	        end);
end

function MainScene:onEnter()
end

function MainScene:onExit(  )
	
end

return MainScene
