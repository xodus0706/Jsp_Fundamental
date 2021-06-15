//weather.js
 
const weather = document.querySelector("#js_weather");
const now = document.querySelector(".now");
const status = document.querySelector(".humidity");
const maxmin = document.querySelector(".max_min_temp");
const feels = document.querySelector(".feel");
const weatherIcon = document.getElementById('icon');
const commentmessage = document.querySelector(".comment");

const COORDS = "coords";
const API_key = "ec1a6b926ab4ad92e04e244e2441e3d0";

function getWeather(lat, lng) {
    fetch(`http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=${API_key}&units=metric`
    ).then(function (response) {
        return response.json();
    }).then(function (json) {
        const temperature = json.main.temp;
        const place = json.name;
        const hum = json.main.humidity;
        const iconid = json.weather[0].icon;
        const max = json.main.temp_max;
        const min = json.main.temp_min;
        const feel = json.main.feels_like;
        console.log(`http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=${API_key}&units=metric`);
		 $.ajax({
		       url : 'englishToKorean.jsp?dong='+encodeURIComponent(place),
		      	type : 'GET',
		       	dataType : 'html',
		       	error : function(){
		       		console.log('error');
		       	},
		       	success : function(html){	
		        	weather.innerHTML = html;
		       	}
		   });
       	//weather.innerHTML = `${place}`
       	
        now.innerText = `현재 온도 : ${temperature}°C`
        maxmin.innerText = `최고 : ${max}°C / 최저 : ${min}°C `
        feels.innerText = `체감온도 ${feel}°C`
        weatherIcon.src = `https://openweathermap.org/img/wn/${iconid}@2x.png`
        status.innerText = `습도:${hum}%`
        if(iconid == "01d" || iconid == "01n"){
        	commentmessage.innerText = `날씨가 맑으며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "02d" || iconid == "02n"){
        	commentmessage.innerText = `구름사이 햇빛이 쬐며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "03d" || iconid == "03n"){
        	commentmessage.innerText = `구름이 다소 있으나 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "04d" || iconid == "04n"){
        	commentmessage.innerText = `구름이 많이 끼어있으며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "09d" || iconid == "09n"){
        	commentmessage.innerText = `비가 아주 많이 내리며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "10d" || iconid == "10n"){
        	commentmessage.innerText = `비가 살짝 내리며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "11d" || iconid == "11n"){
        	commentmessage.innerText = `천둥번개가 치며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else if(iconid == "13d" || iconid == "13n"){
        	commentmessage.innerText = `눈이 내리며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        else{
        	commentmessage.innerText = `안개가 있으며 `
        	if(temperature >= 30){
        		commentmessage.innerText += ` 다소 덥겠습니다.`
        	}
        	else{
        		commentmessage.innerText += ` 덥지는 않겠습니다.`
        	}
        }
        
    })
}

function saveCoords(coordsObj) {
    localStorage.setItem(COORDS, JSON.stringify(coordsObj))
}

function handleGeoSuccess(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    const coordsObj = {
        latitude,
        longitude
    }
    saveCoords(coordsObj)
    getWeather(latitude, longitude);
}

function handleGeoError() {
    console.log("Can't access geolocation");
}
function askForCoords() {
    navigator.geolocation.getCurrentPosition(handleGeoSuccess, handleGeoError);
    // navigator.geolocation.getCurrentPosition(success[, error[, [options]])
}

function loadCoords() {
    const loadedCoords = localStorage.getItem(COORDS);
    if (loadedCoords === null) {
        askForCoords();
    } else {
        const parseCoords = JSON.parse(loadedCoords);
        getWeather(parseCoords.latitude, parseCoords.longitude);
    }
}

function init() {
    loadCoords();
};
init();