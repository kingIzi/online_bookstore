#include "SyRequests.h"
#include <QJsonObject>


//initialze class members
SyRequests::SyRequests(QObject *parent) : QObject(parent)
{
    this->_manager = std::make_unique<Manager>(this);
}

//Perform GET
void SyRequests::GET(const QUrl &url)
{

}

//Perform POST
Reply* SyRequests::POST(const QUrl &url, const QJsonDocument &payLoad, const char *contentTypeHeader)
{
    Request req((QUrl(url)));
    req.setHeader(Request::ContentTypeHeader,contentTypeHeader);
    return this->_manager.get()->post(req,payLoad.toJson());
}

//Get username and password and perform post to sign up with email password endpoint
void SyRequests::signUpWithEmailPassword(const QString &username, const QString &password)
{
    if (username.isEmpty() || password.isEmpty()) { return; }
    const PayLoad payLoad(SignUpTuple(username,password,true));
    const auto document = QJsonDocument::fromVariant(payLoad.getSignUpWithEmailPasswordPayLoad());
    const auto url = EndPoints().getSignUpWithEmailPassword();
    this->_reply = std::make_shared<Reply*>(this->POST(url,document,"application/json"));
    this->makeSignUpWithEmailPasswordRequest();

}

//Get username and password and perform post to sign up with email password endpoint
void SyRequests::signInWithEmailPassword(const QString &username, const QString &password)
{
    if (username.isEmpty() || password.isEmpty()) { return; }
    const PayLoad payLoad(SignInTuple(username,password,true));
    const auto document = QJsonDocument::fromVariant(payLoad.getSignInWithEmailPasswordPayLoad());
    const auto url = EndPoints().getSignInWithEmailPassword();
    this->_reply = std::make_shared<Reply*>(this->POST(url,document,"application/json"));
    this->makeSignInWithEmailPasswordRequest();
}

void SyRequests::makeSignUpWithEmailPasswordRequest()
{
    const auto handler = [this] () { return static_cast<Reply*>((*this->_reply.get())); };
    QObject::connect(handler(),&Reply::readyRead,this,[this,handler]{
        const auto document = QJsonDocument::fromJson(handler()->readAll());
        const auto response = document.object();
        if (response.contains("error")){

        }
        else if (response.contains("kind")){
            emit this->signUpSuccessful();
        }
    });
}

void SyRequests::makeSignInWithEmailPasswordRequest()
{
     const auto handler = [this] () { return static_cast<Reply*>((*this->_reply.get())); };
     QObject::connect(handler(),&Reply::readyRead,this,[this,handler]{
         const auto document = QJsonDocument::fromJson(handler()->readAll());
         const auto response = document.object();
         if (response.contains("error")){

         }
         else if (response.contains("kind")){
             emit this->signInSuccessful();
         }
     });
}

//sign up with email password endpoint
const QString SyRequests::EndPoints::getSignUpWithEmailPassword() const
{
    return QString(this->signUpWithEmailPassword) + APIKEY;
}

//sign in with email password endpoint
const QString SyRequests::EndPoints::getSignInWithEmailPassword() const
{
    return QString(this->signInWithEmailPassword) + APIKEY;
}

template<class T>
SyRequests::PayLoad<T>::PayLoad(T tuple) :
    tuple(tuple)
{}

template<class T>
const QVariantMap SyRequests::PayLoad<T>::getSignUpWithEmailPasswordPayLoad() const
{
    QVariantMap payload;
    payload["email"] = std::get<0>(this->tuple);
    payload["password"] = std::get<1>(this->tuple);
    payload["returnSecureToken"] = std::get<2>(this->tuple);
    return payload;
}

template<class T>
const QVariantMap SyRequests::PayLoad<T>::getSignInWithEmailPasswordPayLoad() const
{
    QVariantMap payload;
    payload["email"] = std::get<0>(this->tuple);
    payload["password"] = std::get<1>(this->tuple);
    payload["returnSecureToken"] = std::get<2>(this->tuple);
    return payload;
}
