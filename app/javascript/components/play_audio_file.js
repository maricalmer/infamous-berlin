const playFileOnClick = () => {
  const players = document.querySelectorAll(".play-audio-js")
  players.forEach(player =>
    player.addEventListener("click", function(event) {
      const player = event.currentTarget.lastElementChild
      if (player.paused) {
        player.play()
      } else {
        player.pause()
      }
    })
  )
}

export { playFileOnClick };
