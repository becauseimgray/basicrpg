--Art from: Curt - cjc83486,  http://opengameart.org/content/rpg-character

function love.load()
  --basic variables
  lg      = love.graphics;
  width   = lg.getWidth();
  height  = lg.getHeight();
  universal_size = 35;

  --player object
  player = {};
  player.x = 0;
  player.y = 0;
  player.size = universal_size;
  player.image = lg.newImage("images/down.png"); --default is down position
  player.direction = {0, 0}
  player.w = player.image:getWidth();
  player.h = player.image:getHeight();
  player.attack = false;
  player.hp = 100;
  player.inventory = {};
  player.inventory.hasSword = false;

  --image loading for map
  grass   = lg.newImage("images/grass.png");

  --basic size of blocks for map
  block_width   = universal_size;
  block_height  = universal_size;

  --z index of block
  block_depth = 0;


  --create grid
  grid = {};
  grid.x = 0;
  grid.y = 0;
  grid.size = universal_size;


--sets all spots in grid to 1 (grass)
  for x = 0, grid.size do
      grid[x] = {};
      for y = 0, grid.size do
        grid[x][y] = 1;
      end
  end
end --end of load function

function love.draw()
 for x = 0, grid.size do
   for y = 0, grid.size do -- loop through grid to find grass spots
      if grid[x][y] == 1 then
         love.graphics.draw(grass, x * grid.size, y * grid.size); -- if grass, draw grass image
      end
  end
 end

 --boundaries of player
 --top, left
 if (player.x * grid.size) < 0 then player.x = 0 end
 if (player.y * grid.size) < 0 then player.y = 0 end
 --bottom, right
 if player.x + player.w > width  then player.x = (width  - grid.size) end
 if player.y + player.h > height then player.y = (height - grid.size) end



 --draw player at its x and y coord
 love.graphics.draw(player.image, player.x, player.y);

 if player.attack == true then -- if player is attacking, draw graphic to show it
    lg.setColor(255,0,0);
    lg.rectangle("fill", player.x, player.y, 35, 35);
    lg.setColor(255,255,255);
  end

end -- end of draw function

function love.update(dt)
  player.w = player.w + player.direction[1];
  player.h = player.h + player.direction[2];

  --keep player from flying away
  if player.x == player.x * universal_size then
    player.direction[1] = 0;
  elseif player.y == player.y * universal_size then
    player.direction[2] = 0;
  end
  --set movement
      if love.keyboard.isDown("w") then
                player.y = player.y - player.size/4;
                player.direction = {0, -1};
                player.image = lg.newImage("images/up.png");
      elseif love.keyboard.isDown("s") then
                player.y = player.y + player.size/4;
                player.direction = {0, 1};
                player.image = lg.newImage("images/down.png");
      elseif love.keyboard.isDown("a") then
                player.x = player.x - player.size/4;
                player.direction = {-1, 0};
                player.image = lg.newImage("images/left.png");
      elseif love.keyboard.isDown("d") then
                player.x = player.x + player.size/4;
                player.direction = {1, 0};
                player.image = lg.newImage("images/right.png");
      end

      if love.keyboard.isDown(" ") then
        --if space is pressed, attack
            player.attack = true;
        elseif key ~= " " then
          player.attack = false;
        end
end --end of update function

-- function love.keypressed(key) --function for player movement
--   if     key == "w" then
--             player.y = player.y - player.size;
--             player.direction = {0, -1};
--             player.image = lg.newImage("images/up.png");
--   elseif key == "s" then
--             player.y = player.y + player.size;
--             player.direction = {0, 1};
--             player.image = lg.newImage("images/down.png");
--   elseif key == "a" then
--             player.x = player.x - player.size;
--             player.direction = {-1, 0};
--             player.image = lg.newImage("images/left.png");
--   elseif key == "d" then
--             player.x = player.x + player.size;
--             player.direction = {1, 0};
--             player.image = lg.newImage("images/right.png");
--   end
