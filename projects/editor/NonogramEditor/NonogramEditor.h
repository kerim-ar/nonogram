#ifndef NONOGRAMEDITOR_H
#define NONOGRAMEDITOR_H

#include <QDir>
#include <QObject>
#include <QString>
#include <QJsonObject>

class NonogramEditor : public QObject
{
    Q_OBJECT
public:

    Q_ENUMS(Mode)
    enum Mode {
        Launcher,
        NonogramCreatorMaster,
        NonogramView
    };

    explicit NonogramEditor(QObject *parent = 0);

    Q_INVOKABLE
    QStringList getFileList();

    Q_INVOKABLE
    QJsonObject getJsonObject(const QString &filePath);

    Q_INVOKABLE
    void saveInTextFile(const QJsonObject & nonogramJson);

public slots:
    void saveNonogram(const QJsonObject & nonogramJson);

signals:

private:
    QString arrayToString(const QJsonArray & cells);

    static const QString FILE_EXTENSION;
    static const QString NONOGRAMS_FOLDER;
    static const QString PUBLISHED_FILE_EXTENTION;

    QString m_fileName;
    QDir m_workingDirectory;
};

#endif // NONOGRAMEDITOR_H
