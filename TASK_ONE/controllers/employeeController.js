const fs = require('fs')

exports.ArrageEmplyeeFiles = (req, res) => {
    const reqInput = convertTextFileToJson('./reqInput.txt')
    res.send(reverseKeyValueOfJsonsArray(reqInput))
}

const convertTextFileToJson = (TextFilePath) => {
    return JSON.parse(fs.readFileSync(TextFilePath))
}

const reverseKeyValueOfJsonsArray= (jsonArray) => {
    var output = {}
    for (const json of jsonArray) {
        for (const [key, value] of Object.entries(json)) {
            if (isJsonValueEmpty(output, value))
                output[value] = []
            output[value].push(key);
        }
    }
    return convertJsontoJsonsArray(output)
}

const isJsonValueEmpty = (json, value) => {
    if (json[value] == null) 
        return true
    return false
}

const convertJsontoJsonsArray = (json) => {
    var output = []
    for (const [key, value] of Object.entries(json)) {
        var json = {}
        json[key]=value
        output.push(json);
    }
    return output
}



