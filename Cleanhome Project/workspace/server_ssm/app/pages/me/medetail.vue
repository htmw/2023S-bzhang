<template>
	<view>
		<u-navbar title="personal information" :border="true" :placeholder="true"   :autoBack="true"></u-navbar>
		<scroll-view :enable-flex="true" class="svcontainer">
			<view class="formitem">
				<view class="formlabel">Choose Avatar:</view>
				<ideaUpload v-model="filelist"></ideaUpload>
				<!--  #ifdef MP-WEIXIN -->
				<button open-type="chooseAvatar" @chooseavatar="getWxAvatar">Set Avatar</button>
				<!--  #endif -->
			</view>
			<view class="formitem">
				<view class="formlabel">username:</view>
				<input id="nickname-input" @blur="setNickName" type="nickname" v-model="fobj.username" class="binput1" />
			</view>
			<view class="formitem">
				<view class="formlabel">phone number:</view>
				<input type="tel" v-model="fobj.tel" class="binput1" />
				<!--  #ifdef MP-WEIXIN -->
				<button open-type="getPhoneNumber" @getphonenumber="getPhoneNumber">get phone number</button>
				<!--  #endif -->
			</view>
			<view class="formitem">
				<view class="formlabel">password:</view>
				<input type="password" v-model="fobj.passwd" class="binput1" />
			</view>
			<view class="formitem">
				<view class="formlabel">gender:</view>
				<view>
					<radio-group @change="showSex">
						<label class="radio"><radio value="male" :checked="fobj.sex=='male'" />male</label>
						<label class="radio"><radio value="female" :checked="fobj.sex=='female'" />female</label>
					</radio-group>
				</view>
			</view>
			<view v-if="fobj.roletype=='4'">
				<view>
					<u-divider text="health information:"></u-divider>
				</view>
				<u-form-item label-width="76" label="body temperature:" prop="" borderBottom="1">
					<u--input border="none" type="text" v-model="fobj.tiwen" />
				</u-form-item>
				<u-form-item label-width="76" label="self feeling:" prop="" borderBottom="1">
					<u--input border="none" type="text" v-model="fobj.jknote" />
				</u-form-item>
			</view>

			<view class="formitem">
				<button type="primary" @click="updateInfo()">submit</button>
			</view>
			
		</scroll-view>
	</view>
</template>

<script>
	import { listj, findj, savej, fileUrl, saveWxUser, uploadUrl } from '@/common/config/api.js'
	import {mapState, mapActions} from 'vuex'
	import ideaUpload from '@/components/idea-upload/idea-upload.vue'
	import { serverUrl } from '@/common/config/api.js'
	export default {
		components: {ideaUpload},
		data() {
			return {
				fobj: {},
				filelist: [],
				fileUrl: fileUrl,
				uploadUrl: uploadUrl,
				nickname: ''
			}
		},
		onLoad(params) {
			this.fobj = this.userInfo
			setTimeout(()=>{
				this.filelist.push({url: this.fileUrl + this.fobj.img})
			},100)
			
			console.log(this.filelist)
		},
		methods: {
			...mapActions(['updateUserInfo']),
			getUploadImg(imgurl){
				if(imgurl){
					this.fobj.img = imgurl
				}
			},
			getWxAvatar(e){
				let imgurl = e.detail.avatarUrl
				
				
				/* saveWxUser({params: { imgurl: imgurl }}).then(res => {
					this.fobj.img = res
				}).catch(err => {
				 
				}) */
				console.log("upload url:"+this.uploadUrl+" imgurl:"+imgurl)
				uni.uploadFile({
					url: uploadUrl, //仅为示例，非真实的接口地址
					filePath: imgurl,
					name: 'file',
					success: (uploadFileRes) => {
						let img = uploadFileRes.data
						console.log("uploadresult:"+img);
						this.fobj.img = img
						this.filelist = [{url: this.fileUrl+img, fileName:img}]
					}
				});
				
				
			},
			goBack(){
				uni.navigateBack({
					delta:1
				})
			},
			showSex(v){
				this.fobj.sex = v.detail.value
			},
			setNickName(event){
				uni.createSelectorQuery().in(this)  
				    .select("#nickname-input")  
				    .fields({  
				        properties: ["value"],  
				    })  
				    .exec((res) => {  
				        const nickName = res?.[0]?.value  
				        console.log('nickName', nickName)
						this.fobj.username = nickName
						if (nickName) {
							findj({params: {table: 'user', username: nickName}}).then(res2 => {
								console.info(res2)
								if (res2 && res2.id!=this.userInfo.id) {
									uni.showToast({
										icon:'error',
										title: 'Username already exists!'
									})
									this.fobj.username = ""
								}
							}).catch(err => {
							 
							})
						}
				    })
			},
			updateInfo() {
				if (this.fobj.username && this.fobj.tel) {
					this.fobj.table = 'user'
					if (this.filelist.length) {
						this.fobj.img = this.filelist[0].fileName
					}
					console.log("userimg======="+this.fobj.img)
					this.updateUserInfo(this.fobj)
					savej({params: this.fobj}).then(res => {
						uni.showToast({
							icon:'error',
							title: 'Successful operation!'
						})
					}).catch(err => {
					 
					})
				}else{
					uni.showToast({
						icon:'error',
						title:'please check the input'
					})
				}
				
			},
			getPhoneNumber(e) {
			
				console.log(e.detail.errMsg) // 判断用户是否允许获取手机号
				console.log(e.detail.iv) // 参数 iv
				console.log(e.detail.encryptedData) // 参数encryptedData
				if (e.detail.errMsg == "getPhoneNumber:ok") { // 用户允许或去手机号
					uni.request({
						url: this.serverUrl+"database/getWxPhoneNumber",
						data: {
							code: e.detail.code,
							encryptedData: e.detail.encryptedData,
							iv: e.detail.iv,
							sessionKey: this.session_key,
							openId: this.openId,
						},
						success: (res) => {
							if(res.data.errcode == 0){
								console.info(res.data.phone_info.phoneNumber)
								this.fobj.tel = res.data.phone_info.phoneNumber
							}
						}
					})
				}
			}
		},
		computed: {
			...mapState(['userInfo'])
		}
	}
</script>

<style lang="scss">

</style>
