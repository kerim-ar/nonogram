#include "NonogramEditor.h"

#include <QUrl>
#include <QDir>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QStandardPaths>
#include <QTextStream>
#include <QDesktopServices>

const QString NonogramEditor::FILE_EXTENSION = ".non";
const QString NonogramEditor::NONOGRAMS_FOLDER = "Nonograms";
const QString NonogramEditor::PUBLISHED_FILE_EXTENTION = ".nonogram.txt";

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

void NonogramEditor::saveInTextFile(const QJsonObject &nonogramJson)
{
    QString name = nonogramJson["name"].toString() + PUBLISHED_FILE_EXTENTION;
    QFile file(m_workingDirectory.absolutePath() + "/" + name);
    if (!file.open(QIODevice::WriteOnly)) {
        return;
    }
    QTextStream out(&file);
    out.setCodec("UTF-8");
    out << nonogramJson["name"].toString();
    out << "#" << nonogramJson["width"].toInt();
    out << "#" << nonogramJson["height"].toInt();
    out << "#" << arrayToString(nonogramJson["cells"].toArray());
    file.close();

    QDesktopServices::openUrl(QUrl("file:///" + m_workingDirectory.absolutePath()));
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

QString NonogramEditor::arrayToString(const QJsonArray &cells)
{
    QString res;
    int size = cells.size();
    for (int i = 0; i < size; ++i) {
        res += QString::number(cells[i].toInt());
        if (i != size - 1) {
            res += " ";
        }
    }
    return res;
}
