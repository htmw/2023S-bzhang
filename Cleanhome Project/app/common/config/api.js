const http = uni.$u.http
const rootIp = 'localhost'
const rootUrl = 'http://'+rootIp+':8088/'

export const serverUrl = 'http://'+rootIp+':8088/database/'
export const staticUrl = 'http://'+rootIp+':8088/'
export const fileUrl = 'http://'+rootIp+':8088/upload/'
export const uploadUrl = 'http://'+rootIp+':8088/database/upload'

export const listj = (data) => http.get('list', data)
export const findj = (data) => http.get('find', data)
export const savej = (data) => http.get('save', data)
export const deletej = (data) => http.get('delete', data)
export const listSqlj = (data) => http.get('listSql', data)
export const saveWxUser = (data) => http.get('saveWxUser', data)