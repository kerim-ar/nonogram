#include "NonogramEditor.h"

#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QStandardPaths>

const QString NonogramEditor::FILE_EXTENSION = ".non";
const QString NonogramEditor::NONOGRAMS_FOLDER = "Nonograms";

NonogramEditor::NonogramEditor(QObject *parent) :
    QObject(parent)
{
    QString path = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/" + NONOGRAMS_FOLDER;
    m_workingDirectory.setPath(path);
    if (!m_workingDirectory.exists()) {
        m_workingDirectory.mkdir(path);
    }
}

QStringList NonogramEditor::getFileList()
{
    QFileInfoList fileInfoList = m_workingDirectory.entryInfoList(QStringList("*" + FILE_EXTENSION), QDir::Files | QDir::NoDotAndDotDot, QDir::Time);
    QStringList stringList;
    for (int i = 0; i < fileInfoList.size(); ++i) {
        stringList.push_back(fileInfoList[i].absoluteFilePath());
    }
    return stringList;
}

QJsonObject NonogramEditor::getJsonObject(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly)) {
        return QJsonObject();
    }

    QJsonDocument doc =  QJsonDocument::fromJson(file.readAll());
    file.close();
    return doc.object();
}

void NonogramEditor::saveNonogram(const QJsonObject &nonogramJson)
{
    QString name = nonogramJson["name"].toString() + FILE_EXTENSION;
    QFile saveFile(m_workingDirectory.absolutePath() + "/" + name);

    if (!saveFile.open(QIODevice::WriteOnly)) {
        return;
    }

    QJsonDocument doc(nonogramJson);
    saveFile.write(doc.toJson());
    saveFile.close();
}
