{
  description = "Paul's Custom Packages";

  inputs = {
    snake.url = "path:/home/paul/dev/snake";
  };

  outputs = {self,snake, ...}:
  {
    packages.snake = snake.packages.${builtins.currentSystem}.snake;
  };
}
