		function testFunction() {
			console.log("hi")
			const node = document.getElementById("imgContainer");
			const clone = node.cloneNode(true);
			console.log(node);
			document.getElementById("addDetailForm").appendChild(clone);
		};

		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			} else {
				document.getElementById('preview').src = "";
			}
		}

		( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
				  imageView = function imageView(imgContainer, housePhoto){

				    var attZone = document.getElementById(imgContainer);
				    var btnAtt = document.getElementById(housePhoto)


				    var btnAtt = document.getElementById(housePhoto)

				    var housePhotos = document.getElementById(housePhoto)

				    var sel_files = [];
				    
				    // 이미지와 체크 박스를 감싸고 있는 div 속성
				    var imgContainerClass = 'ui medium rounded image';
				    var imgContainerStyle = 'display:inline-block;position:relative;';
				    // 미리보기 이미지 속성
				    var imgStyle = 'width:70%;height:70%;z-index: 0;display:inline-block;';
				    // 이미지안에 표시되는 체크박스의 속성
				    var chkStyle = 'position:absolute;right: 86px;'
				                  + 'z-index:999; ';
				    var chkClass = 'ui button icon red';
				  
				    btnAtt.onchange = function(e){


				    btnAtt.onchange = function(e){

				    housePhotos.onchange = function(e){

				      var files = e.target.files;
				      var fileArr = Array.prototype.slice.call(files)
				      for(f of fileArr){
				        imageLoader(f);
				      }
				    }  
				    
				  
				    // 탐색기에서 드래그앤 드롭 사용
				    attZone.addEventListener('dragenter', function(e){
				      e.preventDefault();
				      //e.stopPropagation();
				    }, false)
				    
				    attZone.addEventListener('dragover', function(e){
				      e.preventDefault();
				      //e.stopPropagation();
				      
				    }, false)
				  
				    attZone.addEventListener('drop', function(e){
				      var files = {};
				      e.preventDefault();
				      //e.stopPropagation();
				      var dt = e.dataTransfer;
				      files = dt.files;
				      for(f of files){
				        imageLoader(f);
				      }
				      
				    }, false)
				    

				    
				    /*첨부된 이미리즐을 배열에 넣고 미리보기 */
				    imageLoader = function(file){
				      sel_files.push(file);
				      var reader = new FileReader();
				      reader.onload = function(ee){
				        let img = document.createElement('img')
				        img.setAttribute('style', imgStyle)
				        img.src = ee.target.result;
				        attZone.appendChild(makeDiv(img, file));
				      }
				      
				      reader.readAsDataURL(file);
				    }
				    
				    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
				    makeDiv = function(img, file){
					  //이미지를 넣을 div를 만들었음 
				      var imgdiv = document.createElement('div');
				      //div에 class속성을 넣었음 
				      imgdiv.setAttribute('class', imgContainerClass)
				      imgdiv.setAttribute('style', imgContainerStyle)
				      
				      //버튼을 만들었음 
				      var btn = document.createElement('button')
				      //버튼에 속성을 추가함 : 타입은 버튼임
				      btn.setAttribute('type', 'button')
				      btn.setAttribute('delFile', file.name);
				      btn.setAttribute('style', chkStyle);
				      btn.setAttribute('class', chkClass);
				      
				      btn.addEventListener("click", function(ev){
				        var ele = ev.srcElement;
				        var delFile = ele.getAttribute('delFile');
				        for(var i=0 ;i<sel_files.length; i++){
				          if(delFile== sel_files[i].name){
				            sel_files.splice(i, 1);      
				          }
				        }
				        
				        dt = new DataTransfer();
				        for(f in sel_files) {
				          var file = sel_files[f];
				          dt.items.add(file);
				        }
				        btnAtt.files = dt.files;


				        btnAtt.files = dt.files;

				        housePhotos.files = dt.files;

				        var p = ele.parentNode;
				        attZone.removeChild(p)
				      });
				     
				    
				      var trashIcon = document.createElement("i");
				      trashIcon.classList.add("trash", "alternate", "outline", "icon");
				      imgdiv.appendChild(img)
				      imgdiv.append(btn)
				      //btn.innerText("삭제")
				      btn.appendChild(trashIcon)
				      //버튼을 위한 div
				      return imgdiv
				    }
				  }
				)('imgContainer', 'housePhoto')

				)('imgContainer', 'housePhoto')

				)('imgContainer', 'housePhotos')
