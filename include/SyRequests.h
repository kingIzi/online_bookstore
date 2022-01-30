#pragma once
#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QVariantMap>
#include <QJsonDocument>
#include <memory>
#include <QUrl>
#include <tuple>

//Globals
constexpr const char* APIKEY = "AIzaSyA-qupn4cWUvOb9S2qs1SikLZPiS_cbT5g"; //Bad Practice

using Manager = QNetworkAccessManager;
using Reply = QNetworkReply;
using Request = QNetworkRequest;

//tuple data (indexes respectively)
using SignUpTuple = std::tuple<QString,QString,bool>; //username,password,returnSecureToken
using SignInTuple = std::tuple<QString,QString,bool>; //username,password,returnSecureToken

//Class for making all API calls to server
class SyRequests : public QObject
{
    Q_OBJECT
public:
    explicit SyRequests(QObject *parent = nullptr);
    Q_INVOKABLE void openFileDialog();
signals:
    void signInSuccessful();
    void signUpSuccessful();
public slots:
    void signUpWithEmailPassword(const QString& username,const QString& password);
    void signInWithEmailPassword(const QString& username,const QString& password);
private:
    void GET(const QUrl& url);
    Reply* POST(const QUrl& url,const QJsonDocument& payLoad,const char* contentTypeHeader = nullptr);
    void makeSignUpWithEmailPasswordRequest();
    void makeSignInWithEmailPasswordRequest();
private:
    class EndPoints{
    public:
        const QString getSignUpWithEmailPassword() const;
        const QString getSignInWithEmailPassword() const;
        EndPoints() = default;
    private:
        const char* signUpWithEmailPassword = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
        const char* signInWithEmailPassword = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
    };
    template<class T>
    class PayLoad{
    public:
        PayLoad(T tuple);
        const QVariantMap getSignUpWithEmailPasswordPayLoad() const;
        const QVariantMap getSignInWithEmailPasswordPayLoad() const;
    private:
        T tuple;
    };
private:
    std::unique_ptr<Manager> _manager = nullptr;
    std::shared_ptr<Reply*> _reply = nullptr;
};

