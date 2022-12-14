const playFileOnClick = () => {
  const players = document.querySelectorAll(".play-audio-js")
  console.log(players)
  players.forEach(player =>
    player.addEventListener("click", function(event) {
      const player = event.currentTarget.nextElementSibling
      if (player.paused) {
        player.play()
      } else {
        player.pause()
      }
    })
  )
}

export { playFileOnClick };
