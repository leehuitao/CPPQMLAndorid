#ifndef INNERTYPE_H
#define INNERTYPE_H
#include <QDebug>
#define LOGAPI() qWarning()<<"API=>"
#define LOGRESULT() qWarning()<<"RESULT=>"
#define LOGCALLBACK() qWarning()<<"Callback=>"
#define LOGLISTERNER() qWarning()<<"LISTERNER=>"
const std::string HexCode = "0123456789ABCDEF";
std::string HexToString(const std::string &data)
{
    std::string result;
    for (int i = 0; i < data.length(); i += 2)
    {
        std::string byte = data.substr(i, 2);
        char chr = (char) strtol(byte.c_str(), NULL, 16);
        result.push_back(chr);
    }
    return result;
}

std::string StringToHex(const std::string &data)
{

    std::string result ;
    uint8_t currTemp = 0;
    for (int i = 0; i < data.size();  ++i )
    {
        currTemp = data[i] & 0xff;
        result.push_back(HexCode[currTemp>>4]);
        result.push_back(HexCode[currTemp&0x0f]);
    }
    return result;
}
int64_t getTimeMicro()
{
    std::chrono::time_point<std::chrono::system_clock> p = std::chrono::system_clock::now();
    return std::chrono::duration_cast<std::chrono::microseconds>( p.time_since_epoch()).count();
}


int64_t getTimeMilli()
{
    return getTimeMicro() / 1000;
}
#endif // INNERTYPE_H
