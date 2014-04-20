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
    static const QString FILE_EXTENSION;

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

public slots:
    void saveNonogram(const QJsonObject & nonogramJson);

signals:

private:
    static const QString NONOGRAMS_FOLDER;

    QString m_fileName;
    QDir m_workingDirectory;
};

#endif // NONOGRAMEDITOR_H
