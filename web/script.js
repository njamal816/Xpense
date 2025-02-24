function getRandomMessage() {
  let messages = [
    "a budget app for you",
    "a finance tracker for you",
    "a call to start budgeting",
    "you can get on top of your spending",
    "take control of your finances",
    "achieve your financial goals",
    "see where your money goes",
    "an easy way to budget",
    "start saving smartly",
    "stay financially organized",
    "make every penny count",
    "budgeting made simple",
    "empower your financial future",
    "budget like a pro",
    "track your expenses effortlessly",
    "make budgeting a breeze",
    "say goodbye to money stress",
    "get financially fit",
    "save for what matters most",
    "make wise money decisions",
    "budget with confidence",
    "manage your money with ease",
    "smart money management at your fingertips",
    "gain financial peace of mind",
    "take charge of your financial life",
    "start a journey to financial success",
    "learn to spend smarter",
    "plan your financial success",
    "stay on top of your finances",
    "budgeting made rewarding",
    "achieve financial balance",
    "discover financial stability",
    "be in control of your money",
    "financial empowerment made simple",
    "reach your money goals",
    "elevate your financial well-being",
    "master your money",
    "transform your financial habits",
    "organize your money matters",
    "budgeting just got easier",
    "navigate your finances with ease",
    "financial clarity",
    "see your savings grow",
    "take charge of your wallet",
    "financial wisdom unlocked",
    "reach your money milestones",
    "financial planning made easy",
    "discover financial freedom",
    "your budgeting companion",
    "empower your financial journey",
    "say hello to smart spending",
    "build a better financial future",
    "budget like a boss",
    "seize control of your finances",
    "master the art of budgeting",
    "your budget, your rules",
    "track, analyze, thrive",
    "finances made stress-free",
    "make every dollar count",
    "your finances inside out",
    "plan for a prosperous future",
    "transform the way you budget",
    "transform the way you spend",
    "financial confidence",
    "budget smarter, not harder",
    "find peace in budgeting",
    "take charge of your money",
    "financial success begins",
    "personalized budgeting made easy",
    "your guide to financial stability",
    "stay ahead of your expenses",
    "smart budgeting, brighter life",
    "empower your financial decisions",
    "where financial goals become reality",
    "start budgeting like a pro",
    "unlock your financial potential",
    "budgeting for a brighter future",
    "the power to control your finances",
    "budgeting made efficient",
    "the gateway to financial prosperity",
    "your partner in financial growth",
    "redefine your financial future",
    "the budgeting tool you need",
    "embrace a budget-friendly lifestyle",
    "financial intelligence at your fingertips",
    "reach your dreams with smart budgeting",
    "your compass to financial success",
    "where budgeting becomes second nature",
    "unlock the potential of your money",
    "take control of your financial destiny",
    "the key to unlocking financial freedom",
    "crack the budgeting code with Xpensly",
    "harvest financial growth with Xpensly",
    "watch your money grow like a Xpensly",
    "unlock financial wellness, go Xpensly",
    "let Xpensly nurture your finances",
    "budgeting made as easy as Xpensly",
    "get nutty about budgeting with Xpensly",
    "savor the flavor of financial freedom, Xpensly-style",
    "stay cash-ewry by budgeting",
    "reach your goals, one Xpensly at a time",
    "track, save, and grow, the Xpensly way",
    "put a Xpensly on overspending",
    "your budget's best friend: Xpensly",
  ]
  let randomNumber = Math.floor(Math.random() * messages.length);
  return messages[randomNumber]
}

function startTitleAnimation(quickFirst=false, oldMessage="") {
  let message = getRandomMessage();
  let element = document.getElementById("intro-message");
  if(oldMessage == message) message = getRandomMessage();
  let intervalClear;
  let intervalCreate;
  let i = 0;

  if(quickFirst){
    element.textContent = message;
  } else {
    intervalCreate = setInterval(function() {
      if ( document.hidden ) { return; }
      if (i > message.length) {
        clearInterval(intervalCreate);
      } else {
        element.textContent = message.substring(0, i);
        i++;
      }
    }, 40);
  }


  z = 0;
  setTimeout(()=>{
    intervalClear = setInterval(function() {
      if ( document.hidden ) { return; }
      if (z >= message.length) {
        clearInterval(intervalClear);
        startTitleAnimation(false, message);
      } else {
        element.textContent = message.substring(0, message.length - z);
        z++;
      }
    }, 20);
  }, 3300 + 40 * message.length - (quickFirst ? 1000 : 0))
}

function iOS() {
  return [
    "iPad Simulator",
    "iPhone Simulator",
    "iPod Simulator",
    "iPad",
    "iPhone",
    "iPod"
  ].includes(navigator.platform)
  // iPad on iOS 13 detection
  || (navigator.userAgent.includes("Mac") && "ontouchend" in document)
  || navigator.platform.toUpperCase().indexOf("MAC")>=0
  || /(Mac|iPhone|iPod|iPad)/i.test(navigator.platform)
  || /(iPhone|iPod|iPad)/i.test(navigator.platform)
}

function rearrangeLinks() {
  const appStoreLink = document.querySelector("#appStoreLink");
  const googlePlayLink = document.querySelector("#googlePlayLink");

  if (iOS()) {
    // iOS is true - move the App Store link before the Google Play link
    googlePlayLink.parentNode.insertBefore(appStoreLink, googlePlayLink);
  }
}

document.addEventListener("DOMContentLoaded", function() {
  const id = window.location.hash.replace("#","");
  if (id) {
      const detailsElement = document.getElementById(id);
      if (detailsElement) {
        detailsElement.open = true;
        const content = detailsElement.querySelector("summary ~ *");
        content.style.height = "auto";
        content.style.opacity = "1";
        content.style.transition = "";
        setTimeout(() => {detailsElement.scrollIntoView({ behavior: "instant" }); }, 10);
        setTimeout(() => {detailsElement.scrollIntoView({ behavior: "instant" }); }, 50);
        setTimeout(() => {detailsElement.scrollIntoView({ behavior: "instant" }); }, 100);
      }
  }

  initializeDetailsElements(document.querySelectorAll("details"));
});

function initializeDetailsElements(detailsElements){
  detailsElements.forEach(details => {
    details.addEventListener("click", function(event) {
      if (event.target.tagName === "SUMMARY") {
        event.preventDefault();
        toggleDetails(details);
      }
    });

    // Create a MutationObserver to watch for changes to the open attribute
    const observer = new MutationObserver(mutations => {
      mutations.forEach(mutation => {
        if (mutation.type === "attributes" && mutation.attributeName === "open") {
          animateDetails(details, true);
        }
      });
    });

    observer.observe(details, { attributes: true });
 });

 function toggleDetails(details) {
  if (details.open) {
    animateDetails(details, false);
    setTimeout(() => { details.open = false; }, 250);
  } else {
    details.open = true;
    animateDetails(details, true);
  }

  if (details.id) {
    history.pushState(null, null, `#${details.id}`);
  }
}

function animateDetails(details, open) {
  const content = details.querySelector("summary ~ *");

  if (open) {
    content.style.height = "auto";
    const height = content.scrollHeight + "px";
    content.style.height = "0px";
    setTimeout(() => {
      content.style.height = height;
      content.style.opacity = "1";
    }, 0);
  } else {
    content.style.height = content.scrollHeight + "px";
    setTimeout(() => {
      content.style.height = "0px";
      content.style.opacity = "0";
    }, 0);
  }

  content.addEventListener("transitionend", function handler() {
    content.style.height = open ? "auto" : "0px";
    content.removeEventListener("transitionend", handler);
  });
}
}

function searchAndHighlight() {
  const searchInput = document.getElementById("search-input").value.toLowerCase();
  const resultsContainer = document.getElementById("results");
  document.getElementById("results").innerHTML = "";
  document.getElementById("search-results-container").className = "";

  if(searchInput.trim().length <= 1) return

  const detailsElements = document.querySelectorAll("details");

  let found = false;

  detailsElements.forEach(details => {
      const summary = details.querySelector("summary");
      const div = details.querySelector("div");

      const searchText = summary.textContent.toLowerCase() + " " + div.textContent.toLowerCase();
      if (searchText.includes(searchInput)) {
        found = true;
        const clonedDetails = details.cloneNode(true)
        clonedDetails.querySelector("summary").innerHTML = highlightText(summary.textContent, searchInput);
        clonedDetails.querySelector("div").innerHTML = highlightText(div.innerHTML, searchInput);
        resultsContainer.appendChild(clonedDetails);
      }
  });

  document.getElementById("search-results-container").className = "results-found-container";

  if (!found) {
    const noResultsMessage = document.createElement("p");
    noResultsMessage.style.paddingTop = "8px"
    noResultsMessage.style.textAlign = "center";
    noResultsMessage.textContent = "No results.";
    resultsContainer.appendChild(noResultsMessage);
  }

  const newDetailsElements = document.getElementById("results").querySelectorAll("details");
  initializeDetailsElements(newDetailsElements)

}

function highlightText(text, search) {
  const regex = new RegExp(`(${search})(?![^<]*>)`, "gi");
  return text.replace(regex, match => `<span class="highlight">${match}</span>`);
}