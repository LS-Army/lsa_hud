window.addEventListener("message", (event) => {
  if (event.data.type === "show") {
    document.body.style.display = "block";
    const healthBar = document.querySelector(".health");
    healthBar.style.width = event.data.health + "%";

    const armorThresholds = [100, 80, 65, 50, 35, 16];
    const armorSegments = document.querySelectorAll(".armor-segment");
    const armorValue = Math.round(event.data.armor);

    for (let i = 0; i < armorSegments.length; i++) {
      const backgroundColor =
        armorValue >= armorThresholds[i]
          ? "rgba(34, 139, 230, 1)"
          : "rgba(16, 17, 19, 0.55)";
      armorSegments[i].style.backgroundColor = backgroundColor;

      const boxShadow =
        armorValue >= armorThresholds[i]
          ? "0px 0px 8px rgba(34, 139, 230, 1)"
          : "0px 0px 8px rgba(16, 17, 19, 1)";
      armorSegments[i].style.boxShadow = boxShadow;
    }
  }
});
