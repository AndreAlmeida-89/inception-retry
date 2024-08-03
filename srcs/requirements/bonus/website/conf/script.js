document.addEventListener("DOMContentLoaded", () => {
  const ball = document.getElementById("ball");

  const screenWidth = window.innerWidth;
  const screenHeight = window.innerHeight;

  ball.style.left = screenWidth / 2 - ball.offsetWidth / 2 + "px";
  ball.style.top = screenHeight / 2 - ball.offsetHeight / 2 + "px";

  let x = parseInt(ball.style.left);
  let y = parseInt(ball.style.top);

  const speed = 20;

  document.addEventListener("keydown", (event) => {
    switch (event.key) {
      case "ArrowLeft":
        x -= speed;
        break;
      case "ArrowRight":
        x += speed;
        break;
      case "ArrowUp":
        y -= speed;
        break;
      case "ArrowDown":
        y += speed;
        break;
    }
    ball.style.left = x + "px";
    ball.style.top = y + "px";
  });
});
